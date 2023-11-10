//
//  PinSDKCustomViewController.swift
//  eMoneySDK
//
//  Created by Saud Waqar on 02/10/2023.
//

import UIKit
//import IQKeyboardManagerSwift
import Alamofire

class PinSDKCustomViewController: BaseViewController {
    
    @IBOutlet weak var textFieldPin: StandardTextField!
    @IBOutlet weak var buttonVerify: BaseButton!
    @IBOutlet weak var btnShowHide: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isPasswordHide: Bool = true
    var delegate : SendDataSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isHideNavigation(false)
        // Do any additional setup after loading the view.
        delegate?.sendStringData(string: "enter_pin".localized)
//        self.navigationItem.setTitle(title:"enter_pin".localized, subtitle: "")
//        navigationTitleLabel.text = "enter_pin".localized
        titleLabel.text = "enter_pin_to_login".localized
        self.textFieldPin.title = "enter_pin".localized
        self.textFieldPin.state = .normal
        self.textFieldPin.textFieldFont = AppFont.appRegular(size: .h7)
        self.textFieldPin.textFieldTextColor = AppColor.eAnd_Black_80
        self.textFieldPin.entryType = .numberPad
        self.textFieldPin.state = .normal
        
        btnShowHide.setTitle("show".localized, for: .normal)
        btnShowHide.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
        btnShowHide.titleLabel?.font = AppFont.appMedium(size: .body4)
        btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
        
        setIsPasswordHide(passwordHide: isPasswordHide)
        
        self.buttonVerify.setTitle("verify".localized, for: .normal)
        self.buttonVerify.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
        IQKeyboardManager.shared.enable = true
        
//        if SDKColors.shared.accessToken == nil {
//            Loader.shared.showFullScreen()
            self.getToken()
//        } else {
//            Loader.shared.showFullScreen()
//            sendOTP()
//        }
        
        self.keyboardCallBack = { (isHidden, frame) in
            if isHidden {
                self.delegate?.changeScreenSize(size: .halfScreen, viewHeight: 0)
            } else {
                self.delegate?.changeScreenSize(size: .fullScreen, viewHeight: 0)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.sendStringData(string: "enter_pin".localized)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":false])
    }
    
    func getToken() {
        Loader.shared.showFullScreen()
        Task {
            do {
                let response:TokenResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.getToken(token: "bW9iaWxlLWZlOnBhc3N3b3JkMTIz"))
                await MainActor.run {
                    SDKColors.shared.accessToken = response?.data?.accessToken
                    self.sendOTP()
                }

            } catch let error as AppError {
                await MainActor.run {
                    print(error)
                    Loader.shared.hideFullScreen()
                    SDKColors.shared.onFailure?("", error.errorDescription)
                    Alert.showError(title: error.title, message: error.errorDescription)
                }
            }
        }
    }
    
    func parseData(_ data : Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
            if let data = readableJSON["data"], let accessToken = data["accessToken"] as? String {
                SDKColors.shared.accessToken = accessToken//readableJSON["data"]?["accessToken"] as? String
            }
            print(SDKColors.shared.accessToken ?? "")
            self.sendOTP()
        }
        catch {
            print(error)
            Loader.shared.hideFullScreen()
            SDKColors.shared.onFailure?("", error.localizedDescription)
        }
    }
    
    @IBAction func actionVerifyPin(_ sender: BaseButton) {
        print(#function)
        if !(textFieldPin.text.isEmpty) {
            self.loginUser(pin: textFieldPin.text)
        }
    }
    
    @IBAction func btnShowHidePressed(_ sender: Any) {
        isPasswordHide.toggle()
        setIsPasswordHide(passwordHide: isPasswordHide)
    }
    
    
    func proceedWithSelectedFlow(loginModel: LoginResponseModel?) {
        switch SDKColors.shared.flowName {
        case SDKFlowName.changePin.rawValue:
            routToSetupNewPIN()
        case SDKFlowName.updateEmiratesId.rawValue:
            routToUpdateEmirateId()
        case SDKFlowName.login.rawValue:
            self.dismiss(animated: true) {
                if let loginData = loginModel?.data {
                    let baseResponse = BaseResponse(withLoginData: loginData, pin: UserDefaultHelper.userLoginPin ?? "")
                    SDKColors.shared.onLoginSuccess?(baseResponse)
                } else {
                    SDKColors.shared.onFailure?("", EWalletErrorCode.NO_DATA.rawValue)
                }
            }
        default:
            routToAddMoney()
        }
    }
    
    func routToVerifyOtp() {
        var title = ""
        switch SDKColors.shared.flowName {
        case SDKFlowName.addMoney.rawValue:
            title = "add_money".localized
        case SDKFlowName.changePin.rawValue:
            title = "change_pin".localized
        case SDKFlowName.login.rawValue:
            title = "login".localized
        case SDKFlowName.updateEmiratesId.rawValue:
            title = "update_emirates_id".localized
        default:
            title = ""
        }
        let vc = VerifyMobileNumberRouter.setupModule()
        vc.msisdn = GlobalData.shared.msisdn ?? ""
        vc.userJourneyEnum = .registerDevice
        vc.pageTitle = title
        vc.delegate = self.delegate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routToAddMoney() {
        delegate?.sendStringData(string: "Add Money")
        let vc = AddMoneyRouter.setupModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routToUpdateEmirateId() {
        delegate?.sendStringData(string: "Update Emirates Id")
        let vc = CaptureIdentityInfoRouter.setupModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routToSetupNewPIN() {
        delegate?.sendStringData(string: "Reset Pin")
        let vc = SetUpNewPINRouter.setupModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setIsPasswordHide(passwordHide : Bool){
        if passwordHide {
            btnShowHide.setTitle("show".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye"), for: .normal)
            self.textFieldPin.isSecureTextEntry = true
        }
        else {
            btnShowHide.setTitle("hide".localized, for: .normal)
            btnShowHide.setTitleColor(AppColor.eAnd_Error_100, for: .normal)
            btnShowHide.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnShowHide.setImage(UIImage(named:"eye-slash"), for: .normal)
            self.textFieldPin.isSecureTextEntry = false
        }
    }
    
    
    func loginUser(pin: String) {
        Task {
            do {
                Loader.shared.showFullScreen()
                let request = LoginRequestModel()
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
                let loginModel:LoginResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.login(param: request))

                await MainActor.run {
                    if loginModel != nil {
                        // Show cards screen
                        Loader.shared.hideFullScreen()
                        if let oldDevice = loginModel?.data?.oldDeviceId, !oldDevice.isEmpty {
                            // Go to verify otp
                            self.routToVerifyOtp()
                        } else {
                            UserDefaultHelper.userLoginPin = pin
                            UserDefaultHelper.userSessionToken = loginModel?.data?.userToken
                            self.proceedWithSelectedFlow(loginModel: loginModel)
                        }
                    }
                }
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    // Show error
                    Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
                    Loader.shared.hideFullScreen()
                }
            }
        }
    }
    
    func sendOTP() {
        Task {
            do {
                guard let msisdn = SDKColors.shared.msisdn else {
                    Loader.shared.hideFullScreen()
                    SDKColors.shared.onFailure?("", "msisdn is missing")
                    return
                }
                let planeNumber = msisdn.planPhoneNumberString
                let request = VerifyMobileNumberOtpSendRequestModel(isSingleAccount: true,
                                                                    msisdn:planeNumber,
                                                                    identity: planeNumber)
                
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.otpSendToMobile(param: request))
                await MainActor.run {
                    if addPostObject != nil {
                        print("\(#function) response")
                        print(addPostObject?.data ?? "nil addPostObject")
                    }
                    Loader.shared.hideFullScreen()
                }
            } catch let error as AppError {
                print("\(#function) error")
                print(error.localizedDescription)
                Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
                Loader.shared.hideFullScreen()
                SDKColors.shared.onFailure?(error.errorCode, error.errorDescription)
            }
        }
    }
}
