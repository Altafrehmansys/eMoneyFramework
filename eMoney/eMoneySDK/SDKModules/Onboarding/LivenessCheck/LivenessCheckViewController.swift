//
//  LivenessCheckViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 25/04/2023.
//
import UIKit
import EFRSDK

var selectionHomeViewLoaded = false

class LivenessCheckViewController: BaseViewController, EFRSDK.FaceCaptureDelegate {
    
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var encloseCameraView: UIView!
    @IBOutlet weak var addView: UIView!
    
    var selectedIDs  : [Int] = []
    var cameraViewController: EFRSDK.FaceCaptureViewController?
    var capturedFace:EFRSDK.Portrait!
    
    var livenessCheckArray:[LivenessCheckProcess] = []
    var statusShown:Bool = false
    var selectedFrameStyle:Int = 2
    var selectedPortraitCount:UInt8 = 1
    var selectedPortraitTimeOut:UInt8 = 10
    
    var isApiCalled = false
    var pageNumber:Int = 0
    var finalResult:Result?
    var resultPortraitCount:Int = 0
    var resultError:NSError?
    var timer = Timer()
    var profileMatch: Bool = false
    
    @objc var isUpgradeFlow = false
    var popToViewController:AnyClass? = nil
    var registrationSmartLivenessErrorViewControllerPushed = false
    var cofigurationResponse: EFRKeyAndConfigResponseModel?
    
    var updateType:UserUpdateType?
    
    // MARK: - Credentials
    
    // MARK: - View Didload - initialise SDK
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let type = updateType, type == .updateEidAndSelfi{
            self.isUpgradeFlow = true
        }
        
        self.statupMethod()
        
        self.navigationItem.setTitle(title: "register".localized, subtitle: "verify_identity".localized)
//
//        self.stepBar.addRedLine(noOfSteps: 4, currentStep: 2)
//        self.createNavBackBtn(isWhite: true)
        createNavBackBtn()
        /// Initiliase SDK
        if GlobalData.shared.livenessViewLoaded == false {
//            self.initialiseSDKFromEwalletServer()
            setupSDKByTemporaryKeyAndCofiguration()
            GlobalData.shared.livenessViewLoaded = true
        } else {
            setupSDKByTemporaryKeyAndCofiguration()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tryAgainButton.isHidden = true
        self.statusLabel.isHidden = true
    }
    
    func statupMethod(){
        
        UserDefaults.standard.set([], forKey: "selectedFunctions")
        //self.headerHeight.constant = UIScreen.main.bounds.height > 800 ? 120 : 95
        self.view.layoutIfNeeded()
        
        //Check application moved to background
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @objc func appMovedToBackground() {
        SDK.getInstance.stopProcess()
    }
    
    func setupSDKByTemporaryKeyAndCofiguration() {
     
        if let currentResponse = self.cofigurationResponse {
            
            self.cofigurationResponse = currentResponse
            
            guard let configuration = currentResponse.data?.configuration else {
                return
            }
            let configurationData: EFRSDK.EFRSDKResponseData = EFRSDK.EFRSDKResponseData(data: configuration.data ?? "", statusCode: 200)
            
            guard let temporaryKey = currentResponse.data?.temporaryKey else {
                return
            }
            var final = [UInt8](arrayLiteral: 0)
            if let data = Data(base64Encoded: temporaryKey.value ?? "")  {
                final = [UInt8](data)
            }
            let secretKey:SecretKey = SecretKey(code: UInt32(temporaryKey.code ?? "0"), value: final, expiryDateTime: temporaryKey.expiry)
            let configSetting:EFRSDKConfigurationData = EFRSDKConfigurationData(configuration: configurationData, secretKey: secretKey)
            
            DispatchQueue.main.async {
                
                do {
                    try SDK.initialise(configurationSettings: configSetting) { (code:FeedbackMessage)  in
                        DispatchQueue.main.async {
                            if code == .OK{
                                self.startSelectedProcess()
                                self.eWalletRegisterHandlerforExecutionBlock()
                                
                            }else{
                                self.pushLivenessErrorScreen()
                            }
                        }
                    }
                } catch {

                }
            }
        }
    }
 
}



extension LivenessCheckViewController{
    
    // MARK: - Compleion handler for calling api
    
    func eWalletRegisterHandlerforExecutionBlock(){
        
        SDK.getInstance.executionFeedback.setHandler({ (message) in
            
            print("SDK.getInstance.executionFeedback.setHandler")
            Task{
                do {
                    let response:RegistrationLivenessResponse? = try await ApiManager.shared.execute(OnboardingApiRouter.liveness(command: message))
                    await MainActor.run{
                        if let command = response?.data?.command {
                            let responseValue = EFRSDKResponseData(data: command, statusCode: 200)
                            SDK.getInstance.executionFeedback.execute(data: responseValue)
                        }
                    }
                } catch {
                    await MainActor.run{
       
                        let vc = LivenessErrorViewController.instantiate(fromAppStoryboard: .Liveness)
                        vc.errorMsg = ""
                        vc.isPlainError = true
                        vc.delegate = self
                        self.present(vc, animated: true)
                    }
                    print(error.localizedDescription)
                }
            }

        })
    }
    
    // MARK: - Process best face isolation and liveness detection task simultaneously
    
    // Add Capture view to parent view and start process
    
    func startSelectedProcess()  {
        
        DispatchQueue.main.async {
            //self.lblSubTitle.text = ""
        }
        
        //self.livenessCheckArray
        do {
            try SDK.getInstance.liveness.setlivenessChecks(self.livenessCheckArray)
        }catch ValidationError.IllegalArgument {
            // Show alert: ""
        } catch {
            
        }
        
        SDK.getInstance.bestFace.portraitCount = self.selectedPortraitCount
        
        /// UI Customization
        SDK.getInstance.frameShape = FrameStyle(rawValue: self.selectedFrameStyle) ?? .OVAL
        SDK.getInstance.frameCornerRadius = 35 // application only when frame shape is rectangle
        SDK.getInstance.frameStrokeWidth = 2
        SDK.getInstance.frameColorWarningFeedbackMessage = .red
        SDK.getInstance.frameColorNeutralFeedbackMessage = .green
        
        
        self.pageNumber = 0
        
        // Add camera view and start process
        
        self.cameraViewController = SDK.startProcess(on: self) { (result) in
            if self.cameraViewController != nil {
                DispatchQueue.main.async(execute: {() -> Void in
                    
                    Loader.shared.hideFullScreen()
                    
                    print("self.showResultViewPopup")
                    self.showResultViewPopup(result: result)
                    //APi to Server
                })
                self.cameraViewController?.willMove(toParent: nil)
                self.cameraViewController?.view.removeFromSuperview()
                // Remove view from parent vieew
                self.cameraViewController?.removeFromParent()
                self.cameraViewController = nil
//                self.encloseCameraView.alpha = 0.0
                //self.closeButton.alpha = 0.0
            }
        }
        
        
        // Add view over any view
        self.cameraViewController?.delegate = self
        self.cameraViewController?.view.frame = self.addView.bounds
        self.cameraViewController?.willMove(toParent: self)
        if self.cameraViewController != nil{
//            self.encloseCameraView.alpha = 1.0
            //self.closeButton.alpha = 1.0
            self.addView.addSubview((self.cameraViewController?.view!)!)
            self.addChild(self.cameraViewController!)
            self.cameraViewController?.didMove(toParent: self)
        } else {
            //-4
//            self.reTryServiceHit(txt: "It looks like something went wrong. Let's try again")
        }
        
        //     For Closing camera view at any time
        //     SDK.getInstance.stopProcess()
    }
    
}

extension LivenessCheckViewController{
    // MARK: - Delegate methods (completion handler)
    
    // feedback messages while processing tasks
    
    func onFeedback(feedback: Feedback) {
        
        if feedback.bestFaceIsolationState != nil{
            
            print("=========time \(feedback.bestFaceIsolationState?.elapsedSec ?? 0.0)")
            
        }
        
        if feedback.livenessCheckState != nil{
            print("elapsedTime \(feedback.livenessCheckState?.elapsedSec ?? 0.0)")
            print("------------\(feedback.livenessCheckState?.status.description ?? "")")
            switch feedback.livenessCheckState?.status {
            
            case .PENDING:
                
                if !self.statusShown{
                    self.statusShown = true
                    print("\(feedback.livenessCheckState?.code.message ?? "")  - Pending")
                }
                self.startPendingLivenessProcess(feedback: feedback)
                
            case .INPROGRESS:
                if self.statusShown{
                    self.statusShown = false
                    print("\(feedback.livenessCheckState?.code.message ?? "")  - InProgress")
                }
                
                print("elapsedTime \(feedback.livenessCheckState?.elapsedSec ?? 0.0)")
                DispatchQueue.main.async {
                    //self.lblStatus.text = String(format: "%.1f", feedback.livenessCheckState?.elapsedSec ?? 0.0)
                }
                break
            case .PASSED:
                
                self.statusShown = false
                print("\(feedback.livenessCheckState?.code.message ?? "")  - Passed")
                DispatchQueue.main.async(execute: {() -> Void in
//                    EFRLoader.sharedInstance.showLoader()
                    Loader.shared.showFullScreen()
                })
                break
            case .TIMEOUT:
                
                self.statusShown = false
                print("\(feedback.livenessCheckState?.code.message ?? "")  - Timed Out")
                
//                self.()) "It looks like something went wrong. Let's try again"
                self.tryAgainButton.isHidden = true
                self.statusLabel.isHidden = true
                
                
            case .PROCESSING:
                print("\(feedback.livenessCheckState?.code.message ?? "")  - Processing")
                self.tryAgainButton.isHidden = true
                self.statusLabel.isHidden = true
                
//                DispatchQueue.main.async(execute: {() -> Void in
////                    EFRLoader.sharedInstance.showLoader()
//                    Loader.shared.showFullScreen()
//                })
            default:
                break
            }
        }else{
            // print("elapsedTime \(feedback.bestFaceIsolationState?.elapsedSec ?? 0.0)")
            DispatchQueue.main.async {
                //self.lblStatus.text = String(format: "%.1f", feedback.bestFaceIsolationState?.elapsedSec ?? 0.0)
            }
            //-6
//            self.reTryServiceHit(txt: "It looks like something went wrong. Let's try again")
            print("feedback.livenessCheckState failed")
        }
        
        // Show liveness test name
        
        DispatchQueue.main.async {
            if feedback.livenessCheckState != nil{
                //self.lblTitle.text = feedback.livenessCheckState?.code.message ?? ""
            }else{
                //self.lblTitle.text = ""
            }
        }
    }
    
    // Start pending liveness process with or without showing animation
    
    func startPendingLivenessProcess(feedback:Feedback){
        
        SDK.getInstance.liveness.go()
        
    }
    
    
    // Show feedback messages for each frame processed
    
    func showFeedbackMessageDescription(feedBack:[FeedbackMessage]){
        var messageString:String = ""
        for message:FeedbackMessage in feedBack{
            messageString =  messageString + "\(message.message)\n"
        }
        DispatchQueue.main.async {
            //self.lblSubTitle.text = messageString
            
        }
        print("MessageString :\(messageString)")
    }
    
    // final result after processing tasks
    
    func onCompleted(result: Result) {
        //Comment because its call two time
          // self.showResultViewPopup(result: result)
        
    }
}

extension LivenessCheckViewController{
    // MARK: - Process final result
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func showResultViewPopup(result:Result){
        
        
        self.finalResult = result
        self.resultPortraitCount = 0
        
        self.tryAgainButton.isHidden = false
        self.statusLabel.isHidden = false
        
        // Prepare the popup assets
        DispatchQueue.main.async {
            
//            var imageData:Data?
//            var imageHash:Data?
            var finalMessage = ""
            var feedbackMessages = "Messages:\n"
            
            if  result.bestFaceResult != nil {
                
                print(result.bestFaceResult)
                if result.bestFaceResult?.portraits?.count ?? 0 > 0 {
                    self.resultPortraitCount = result.bestFaceResult?.portraits?.count ?? 0
                    
                    
                    let imageString = result.bestFaceResult?.portraits?[self.pageNumber].thumbnail
                    let imagee = self.convertBase64StringToImage(imageBase64String: imageString!)
                    
                    self.view.layoutIfNeeded()
//                    imageData = result.bestFaceResult?.portraits?[self.pageNumber].image
                    //self.portraitImage.image = UIImage(data: imageData!)!
//                    imageHash = result.bestFaceResult?.portraits?[self.pageNumber].imageHash
                    
                    let face = EFRServerValidationFaces()
                    
//                    let imageString = imageData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
                    
                    
//                    var data = Data(base64Encoded: recording_base64, options: .ignoreUnknownCharacters)
                    
                    face.data = result.bestFaceResult?.portraits?[self.pageNumber].image ?? ""//imageData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) ?? ""
                    face.dataHash = result.bestFaceResult?.portraits?[self.pageNumber].imageHash ?? ""//imageHash?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) ?? ""
                    
                    let request = EFRServerValidationRequest()
//                    request.msisdn = "544007731" 971544007731
//                    request.processId = ""

//                    request.cacheFlow = false
                    //request.pin = AESDataEncryption.aes128Encrypt(withSecretText: CommonMethods.getUserPinInDefault() ?? "") ?? ""
                    request.faces = [face];
                    if self.isUpgradeFlow {
                        request.previousProfileName = GlobalData.shared.loginData?.profileName ?? ""
                        request.profileName = GlobalData.shared.loginData?.upgradeToProfile ?? ""
                    }else{
                        request.profileName = "Consumer Physical KYC Profile"
                        request.previousProfileName = "Consumer NO KYC Profile"
//                        if let msisdn = CommonMethods.getMsisdnFromKeychainIfExists(), !msisdn.isEmpty {
//                            request.msisdn = msisdn
//                        }else if let msisdn = CommonMethods.getTempMsisdnFromKeychainIfExists() {
//                            request.msisdn = msisdn
//                        }else{
//                            request.msisdn = ""
//                        }
                    }
                    request.isSingleAccount = GlobalData.shared.isSingleAccount
                    
                    //SSSS
                    if GlobalData.shared.userEidInfo?.emiratesId != nil {
                        request.dateOfBirth = GlobalData.shared.userEidInfo?.dob ?? ""
                        request.nationality = GlobalData.shared.userEidInfo?.nationalityIso3 ?? ""
                        request.registrantNumber = GlobalData.shared.userEidInfo?.emiratesId ?? ""
                        request.expiryDate = GlobalData.shared.userEidInfo?.expiry ?? ""
                        request.firstName = GlobalData.shared.userEidInfo?.firstName ?? ""
                        request.middleName = GlobalData.shared.userEidInfo?.middleName ?? ""
                        request.lastName = GlobalData.shared.userEidInfo?.lastName ?? ""
                        request.fullName = GlobalData.shared.userEidInfo?.fullName ?? ""
                        request.gender = GlobalData.shared.userEidInfo?.sex ?? ""
                    }
                    
                    self.saveData(request:request)
                    
                    self.capturedFace = result.bestFaceResult?.portraits?[self.pageNumber]
                    //self.btnSend.alpha = 1.0
                    finalMessage = finalMessage + "Elapsed Time: \(result.bestFaceResult?.elapsedSec ?? 0.0) \nOverallStatus: \(result.bestFaceResult?.status.description ?? "") \nBlink Count: \(result.bestFaceResult?.eyeBlinkCount ?? 0) \n"
                    
                    finalMessage = finalMessage + "Number of portraits: \(self.resultPortraitCount)"
                    
                    for feedmessage:FeedbackMessage in result.lastWarningMessage {
                        feedbackMessages = feedbackMessages + "- \(feedmessage.name)\n"
                    }
                }else{
                    DispatchQueue.main.async {
                        // Come here when user not show face
                        self.pushLivenessErrorScreen()
                        print("pushLivenessErrorScreen 1")
                    }
                }
            } else{
                DispatchQueue.main.async {
                    print("pushLivenessErrorScreen 2")
                    self.pushLivenessErrorScreen()
                }
            }
            
            // Create the dialog
            //self.alertViewContainer.alpha = 1.0
        }
        // self.saveData([])
        //  self.readMessage()
    }
    
    
    
    func saveData(request : EFRServerValidationRequest)  {
        Loader.shared.showFullScreen()
        
        Task{
            do {
                let response:LivenessRhserResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.rhserv(param: request))
                //self.statusLabel.text = "MATCH"
                self.profileMatch = true
                
                if self.isUpgradeFlow {
                    //update profile status
                    if let responseData = response?.data {
                        GlobalData.shared.loginData?.upgradeScreen = responseData.upgradeScreen
                        GlobalData.shared.loginData?.profileName = responseData.profileName
                        GlobalData.shared.loginData?.upgradeToProfile = responseData.upgradeToProfile
                        GlobalData.shared.userProfile = UserProfile(rawValue: responseData.profileName ?? "")
                    }
                    
                    await MainActor.run{
                        Loader.shared.hideFullScreen()
                        NotificationCenter.default.post(Notification(name: .onUpgradeFlowCompletion))
                        self.dismiss(animated: true)
                    }

                }else{
                    await MainActor.run{
                        Loader.shared.hideFullScreen()
                        let vc = RegisterEmailRouter.setupModule()
                        GlobalData.shared.registrationType = .physicalKyc
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            } catch let error as AppError{
                await MainActor.run{
                    Loader.shared.hideFullScreen()
                    self.profileMatch = false
                    print("error \(error.errorDescription)")
                    self.pushLivenessErrorScreen(error: error)
                }
            }
        }
        
    }
    
    func pushLivenessErrorScreen(error: AppError? = nil) {
        self.statusLabel.text = ""
        var errorString = "selfi_error".localized

        let vc = LivenessErrorViewController.instantiate(fromAppStoryboard: .Liveness)
        vc.modalPresentationStyle = .overCurrentContext

        if let err =  error , err.errorCode == "3" {
            
            errorString = err.errorDescription
            vc.errorMsg = errorString
            vc.isPlainError = true
            vc.delegate = self
            self.present(vc, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //registrationSmartLivenessErrorViewControllerPushed = true
            
            GlobalData.shared.livenesRetriesLeft -= 1
            vc.errorMsg = error?.errorDescription ?? errorString
            vc.delegate = self
            self.present(vc, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        Loader.shared.hideFullScreen()
    }
}

extension LivenessCheckViewController:LivenessErrorViewControllerDelegate{
    func tryAgainBtnTapped() {
        if GlobalData.shared.livenesRetriesLeft <= 0 {
            GlobalData.shared.livenesRetriesLeft = 3
            if self.isUpgradeFlow {
                self.dismiss(animated: true)
            }else{
                self.navigationController?.popToViewController(ofClass: CaptureIdentityInfoViewController.self,isReversed: false)
            }

        } else {
            self.navigationController?.popToViewController(ofClass: CaptureIdentityInfoViewController.self)
        }
    }
    
    func closeBtnTapped() {
        self.navigationController?.popToViewController(ofClass: CaptureIdentityInfoViewController.self)
    }
}
