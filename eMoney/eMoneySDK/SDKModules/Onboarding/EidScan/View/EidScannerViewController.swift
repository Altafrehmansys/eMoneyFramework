    //
    //  EidScannerViewController.swift
    //

import UIKit
import MDRSDK
import Foundation
import AVFoundation

class EidScannerViewController: BaseViewController {
    
    var scannerVM : EidScannerViewModel?
    @IBOutlet weak var sdkMsgLabel: UILabel!
    @IBOutlet weak var scannerView: UIView!
    
    @IBOutlet weak var stepsBar: BaseStepper!
    
    // Params to receive
//    private var isNavigateFromHome: Bool = false
//    @objc var isNavigateForScan: Bool = false
    var isSingleAccountWithNoEID: Bool = false
    var popToViewController:AnyClass? = nil
    
        //Preview
//    @IBOutlet weak var previewView: UIView!
//    @IBOutlet weak var previewImage: UIImageView!
//    @IBOutlet weak var cameraBackBtn: UIButton!
//    @IBOutlet weak var titleLbl: UILabel!
//    @IBOutlet weak var btnRetake: RedBorderButton!
    
    var isFirstTime:Bool = true
    
    var updateType:UserUpdateType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.setTitle(title: "register".localized, subtitle: "scan_front_title".localized, isBlackNav: true)
        
        self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 1)
        self.createNavBackBtn(isWhite: true)
        
        self.scannerVM = EidScannerViewModel(docType: .ID_CARD) // Direct use
        self.initBinding()
        //scannerVM?.sdkCustomization()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = false
//        self.navigationController?.isNavigationBarHidden = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.setTitle(title: "register".localized, subtitle: "scan_front_title".localized, isBlackNav: true)
        self.scannerVM?.readDocument(view: scannerView)
    }

    
    func initBinding(){
        scannerVM?.alertMessage.bind { msg in
            if msg.count > 0 {
                DispatchQueue.main.async {
                    //self.showNormalAlert(title: "Error", msg: msg.description, OKAction: nil)
                   // self.pushStatusViewController(popToViewControllerClass: EidScannerViewController.self, screenTitle: "", messageTitle: "It looks like something went wrong. Let's try again", messageSubTitle: "Please Scan Emirates ID again", isSuccess: false, isAnimated: true)

                    Alert.showBottomSheetError(title: msg, message: "")
                }
            }
        }
        
        scannerVM?.alertMessageSuccess.bind { msg in
            if msg.count > 0 {
                DispatchQueue.main.async {
                    //self.showNormalAlert(title: "Success", msg: msg.description, OKAction: nil)
                }
            }
        }
        
        scannerVM?.sdkMsg.bind { msg in
            if msg.count > 0 {
                DispatchQueue.main.async {
                    self.sdkMsgLabel.text = msg
                }
            }
        }
//        scannerVM?.instructionMsg.bind { msg in
//            DispatchQueue.main.async {
//                self.InstructionLbl.text = msg
//            }
//        }
        scannerVM?.resultSuccess.bind({ status in
            if status{
                DispatchQueue.main.async {
                        //  self.scannerVM?.readDocument(view: self.scannerView)
                    self.navigateToEidReviewScreen()
                }
            }
        })
//        scannerVM?.resultSuccess.bind({ status in
//            if status{
//                DispatchQueue.main.async {
//                    // if is matching
//                    if let eIdData = self.scannerVM?.eIdDataModel.data {
//                        if !(eIdData.documentMismatch ?? false) {
//                            if self.isSingleAccountWithNoEID {
//                                self.navigateToRegistration()
//                            }else{
//                                self.navigateToSelfiFlow()
//                            }
//                        } else {
//                            self.scannerVM?.alertMessage.value = "Document Mismatch."
//                        }
//                    } else {
//                        self.scannerVM?.alertMessage.value = "Scan unsuccessful."
//                    }
//                    
//                    // Show test screen for results
//                    //self.performSegue(withIdentifier: SegueId.ScanToResult, sender: self)
//                }
//            }
//        })
           
        scannerVM?.showLoader.bind({ isShow in
            DispatchQueue.main.async {
                if isShow {
                    Loader.shared.showFullScreen()
                }
                else{
                    Loader.shared.hideFullScreen()
                }
            }
        })
        
        scannerVM?.eidBackScaning.bind({ status in
            if status{
                self.navigationItem.setTitle(title: "register".localized, subtitle: "scan_back_title".localized, isBlackNav: true)
            }
        })
        
//        scannerVM?.showPreviewView.bind({ isShow in
//            DispatchQueue.main.async {
////                self.previewView.isHidden = !isShow
////                self.cameraBackBtn.isHidden = isShow
//                if let img = self.scannerVM?.previewImage{
//                    //self.previewImage.image = img
//                   // self.scannerVM?.continuePress(view: scannerView)
//                }
//            }
//        })
    }
    
    override func popViewController() {
        self.scannerVM?.backBtnPress()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func retakePress(_ sender: UIButton) {
        self.scannerVM?.readDocument(view: scannerView)
        
    }
    
    @IBAction func continuePress(_ sender: UIButton) {
        //AnalyticsManager.fireFBEvent(withTag: "Photo_ID")
        //self.scannerVM?.continuePress(view: scannerView)
    }

    
    // MARK: - Navigation
    
    func navigateToEidReviewScreen(){
        guard let vm = self.scannerVM else {
            return
        }
        let viewController = ReviewEidRouter.setupModule()
        viewController.sdkResponseData = vm.sdkResponseData
        viewController.frontImage = vm.frontImage
        viewController.backImage = vm.backImage
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToRegistration(){
//        guard let eidInfo = self.scannerVM?.eIdDataModel.data else {
//            return
//        }
//        AccountManager.sharedInstance().userEidInfo = eidInfo
//
//        let vc = RegistrationSmartEnterInformationViewController.instantiate(fromAppStoryboard: .RegistrationSmart)
//        vc.isPhysicalKYC = true
//        vc.isComingFromEIDScan = true
//        self.navigationController?.pushViewController(vc, animated: true)
        DocumentReaderSDK.closeDocumentReader()
    }
    
    func navigateToSelfiFlow(){

//        guard let eidInfo = self.scannerVM?.eIdDataModel.data else {
//            return
//        }
        
        // Selfie Screen
//        AccountManager.sharedInstance().userEidInfo = eidInfo
//        let vc = RegistrationSmartVerifyIdentityViewController.instantiate(fromAppStoryboard: .RegistrationSmart)
//        vc.isNavigateFromHome = self.isNavigateFromHome
//        if let popVC = self.popToViewController {
//            vc.poptoViewController = popVC
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
        DocumentReaderSDK.closeDocumentReader()
        
    }
    
//    func callUpdateDocumentApi() {
//
//        guard let resutlDataModel = self.scannerVM?.eIdDataModel.data else {
//            return
//        }
//
//        let requestModel = UpdateDocumentRequestModel()
//
//        requestModel.fullName = resutlDataModel.fullName ?? ""
//        requestModel.nationality = resutlDataModel.nationalityIso3 ?? ""
//        requestModel.dateOfBirth = resutlDataModel.dob ?? ""
//        requestModel.expiryDate = resutlDataModel.expiry ?? ""
//        requestModel.eidNumber = resutlDataModel.emiratesId ?? ""
//        requestModel.gender = resutlDataModel.sex ?? ""
//        requestModel.firstName = resutlDataModel.firstName ?? ""
//        requestModel.secondName = resutlDataModel.middleName ?? ""
//        requestModel.lastName = resutlDataModel.lastName ?? ""
//
//        let profileName = AccountManager.sharedInstance().loginData.profileName ?? ""
//        requestModel.previousProfileName = profileName
//        // check if user is physical kyc and upgradeToProfile is none then send same previousProfileName and profileName
//        let upgradeScreen = AccountManager.sharedInstance().loginData.upgradeScreen;
//        if (upgradeScreen != nil && upgradeScreen != "none"){
//            requestModel.profileName = AccountManager.sharedInstance().loginData.upgradeToProfile ?? ""
//        }else{
//            requestModel.profileName = profileName
//        }
//
//        requestModel.isSingleAccount = AccountManager.sharedInstance().getBitForisSingleAccount()
//        requestModel.pin = CommonMethods.getUserPinInDefault() ?? ""
//
////        requestModel.removeAllMultipart()
////
////        if let frontImgData = resutlDataModel.frontImage?.pngData() {
////            requestModel.addAttachment(toMultipart: "frontImage.jpg", with: frontImgData, withMimeType: "image/jpeg", withFormKey: "frontImage")
////        }
////        if let backImgData = resutlDataModel.backImage?.pngData() {
////            requestModel.addAttachment(toMultipart: "backImage.jpg", with: backImgData, withMimeType: "image/jpeg", withFormKey: "backImage")
////        }
//
//        ProgressIndicator.shared().show(asFullScreen: true)
//
//        NetworkManager.sharedInstance().executeRequest("profile/updateDocument", withInput: requestModel) { response in
//            ProgressIndicator.shared().hide()
//            print(response)
//
//            //CommonMethods.saveProfileNameinUserDefault(withProfileName: requestModel.profileName)
//            if let responseData = response as? UpdateDocumentResponseModel {
//                AccountManager.sharedInstance().loginData.upgradeScreen = responseData.documentData.upgradeScreen
//                AccountManager.sharedInstance().loginData.profileName = responseData.documentData.profileName
//                AccountManager.sharedInstance().loginData.upgradeToProfile = responseData.documentData.upgradeToProfile
//            }
//            if self.isNavigateForScan {
//                if self.popToViewController != nil {
//                    self.navigationController?.popToViewController(ofClass: self.popToViewController!, animated: true)
//                }else{
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            }else{
//                self.navigationController?.popToRootViewController(animated: true)
//            }
//            DocumentReaderSDK.closeDocumentReader()
//        } failureBlock: { error in
//            ProgressIndicator.shared().hide()
//            print(error.debugDescription)
//            self.pushStatusViewController(popToViewControllerClass: EidScannerViewController.self, screenTitle: "", messageTitle: "", messageSubTitle: error.errorDescriptionEn, isSuccess: false, isAnimated: true)
//        }
//
//    }

//    func pushStatusViewController(popToViewControllerClass: AnyClass, screenTitle: String, messageTitle: String, messageSubTitle: String, isSuccess: Bool, isAnimated: Bool) {
//
//        guard let viewController = UIStoryboard(name: "GenericScreens", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")).instantiateViewController(withIdentifier: "SuccessFailureScreenViewController") as? SuccessFailureScreenViewController else { return }
//        viewController.setPageTitle(screenTitle)
//        viewController.mesaageTitle = messageTitle
//        viewController.mesaageDescription = messageSubTitle
//        let statusImage = isSuccess ? "success" : "failure"
//        if let image = UIImage(named: statusImage){
//            viewController.image = image
//        }
//        viewController.screenRootViewControllerClass = popToViewControllerClass
//        viewController.isViewPushed = true
//        viewController.tagId = 1
//        viewController.primaryButtonText = "OK".sentenceCase
//        viewController.isSuccess = isSuccess
//        viewController.hideButton = false
//        self.navigationController?.pushViewController(viewController, animated: true)
//    }
    
//    func showHelpSheet() {
//
//        let alert = UIAlertController(title: "", message: "Select an option to continue", preferredStyle: .actionSheet)
//
//        // Action.
//        let chat = UIAlertAction(title: "Chat with an operator", style: .default, handler: { _ in
//
//            guard let viewController = UIStoryboard(name: "GenericScreens", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")).instantiateViewController(withIdentifier: "HelpSupport") as? LiveChatConfirmationPopupViewController else { return }
//            self.navigationController?.pushViewController(viewController, animated: false)
//
//        })
//        let call = UIAlertAction(title: "Call 800 392 5538", style: .default, handler: { _ in
//
//            CommonMethods.call(atNumber: "8003925538")
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//            print("Cancel")
//        })
//
//        cancel.setValue(UIColor.appRedColor1, forKey: "titleTextColor")
//
//        alert.addAction(chat)
//        alert.addAction(call)
//        alert.addAction(cancel)
//        DispatchQueue.main.async {
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
}

//extension EidScannerViewController{
//    func printa(){
//        print(a)
//    }
//
//
//    func proceedWithCameraAccess() {
//         let status = AVCaptureDevice.authorizationStatus(for: .video)
//         switch (status){
//         case .authorized:
//             break
//         case .notDetermined:
//             AVCaptureDevice.requestAccess(for: .video) { (granted) in
//                 if (granted){
//                     print("AVCaptureDevice.requestAccess")
//                 } else {
//                     self.camDenied()
//                 }
//             }
//             break
//         case .denied:
//             self.camDenied()
//             break
//         case .restricted:
//             let alert = UIAlertController(title: "Restricted",
//                                           message: "You've been restricted from using the camera on this device. Without camera access this feature won't work. Please contact the device owner so they can give you access.",
//                                           preferredStyle: .alert)
//
//             let okAction = UIAlertAction(title: "OK".sentenceCase, style: .default, handler: nil)
//             alert.addAction(okAction)
//             self.present(alert, animated: true, completion: nil)
//
//         @unknown default:
//             break
//
//         }
//     }
//
//     func camDenied() {
//
//         DispatchQueue.main.async {
//
//             let alertText = "Please grant permission to use the Camera so that you can scan emirates ID."
//
//             let alertButton = "Open Settings"
//
//             var goAction = UIAlertAction(title: alertButton, style: .default, handler: nil)
//
//             if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
//
//                 goAction = UIAlertAction(title: alertButton, style: .default, handler: {(alert: UIAlertAction!) -> Void in
//                     UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//                 })
//             }
//
//             let alert = UIAlertController(title: "e& money Would Like To Access the Camera", message: alertText, preferredStyle: .alert)
//             alert.addAction(goAction)
//
//             let goCancel = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in
//                 self.navigationController?.popViewController(animated: true)
//             }
//
//             alert.addAction(goCancel)
//             self.present(alert, animated: true, completion: nil)
//
//         }
//
//     }
// }
 


//class EidScannerViewController: BaseViewController {
//
//    @IBOutlet weak var stepsBar: BaseStepper!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//
//       // self.navigationItem.setTitle(title: "Register".localized, subtitle: "Verify identity".localized, isBlackNav: true)
//
//        self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 1)
//        //        self.addBarButtonItemWithImage(UIImage(named: "backBtn"), .left, self, #selector(self.backbtnTapped))
//        self.createNavBackBtn()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = true
//        //self.isHideNavigation(true)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        (self.navigationController as? BaseNavigationController)?.isBlackNavBar = false
//        //self.isHideNavigation(false)
//    }
//}
