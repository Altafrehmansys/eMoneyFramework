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
        
        if SDKColors.shared.accessToken == nil {
            self.getToken()
        } else {
            Loader.shared.showFullScreen()
            sendOTP()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.sendStringData(string: "enter_pin".localized)
    }
    
    func getToken() {
        Loader.shared.showFullScreen()
        Task {
            do {
                let response:TokenResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.getToken(token: "Basic bW9iaWxlLWZlOnBhc3N3b3JkMTIz"))
                await MainActor.run {
//                    Loader.shared.hideFullScreen()
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
        
//        var request = URLRequest(url: URL(string: "https://enmoneyapim.azure-api.net/gettoken/v1/token?authorization=Basic%20bW9iaWxlLWZlOnBhc3N3b3JkMTIz")!)
//        request.method = HTTPMethod.post
//        request.headers.add(HTTPHeader(name: "custom_header", value: "pre_prod"))
//        if let clientId = SDKColors.shared.clientID {
//            request.headers.add(HTTPHeader(name: "client_id",   value: clientId))
//        }
//        
//        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
//            if let error = error {
//                Loader.shared.hideFullScreen()
//                SDKColors.shared.onFailure?("", error.localizedDescription)
//            }
//            if let data = data {
//                self?.parseData(data)
//            } else {
//                Loader.shared.hideFullScreen()
//                
//            }
//        }.resume()
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
    
    func routToAddMoney() {
        delegate?.sendStringData(string: "Add Money")
        let vc = AddMoneyRouter.setupModule()
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
    
    func routToSetupNewPIN() {
        delegate?.sendStringData(string: "Reset Pin")
        let vc = SetUpNewPINRouter.setupModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loginUser(pin: String) {
        Task {
            do {
                Loader.shared.showFullScreen()
                let request = LoginRequestModel()
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
//                request.identity = SDKColors.shared.msisdn?.planPhoneNumberString
//                request.msisdn = SDKColors.shared.msisdn?.planPhoneNumberString
//                request.flowName = "AddMoney"
                
//                if GlobalData.shared.isDeviceChanged && GlobalData.shared.msisdnStatusData?.oldDeviceId != nil {
//                    request.oldDeviceId = GlobalData.shared.msisdnStatusData?.oldDeviceId ?? ""
//                } else {
//                    request.oldDeviceId = ""
//                }
                
                let loginModel:LoginResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.login(param: request))

                await MainActor.run {
                    if loginModel != nil {
//                        output?.loginRequestResponse(response: loginModel!)
                        // Show cards screen
                        Loader.shared.hideFullScreen()
                        UserDefaultHelper.userLoginPin = pin
                        UserDefaultHelper.userSessionToken = loginModel?.data?.userToken
                        if SDKColors.shared.flowName == flowName.changePin.rawValue {
                            routToSetupNewPIN()
                        } else {
                            routToAddMoney()
                        }
                        
                    }
                }
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
//                    output?.loginRequestResponseError(error:error)
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
