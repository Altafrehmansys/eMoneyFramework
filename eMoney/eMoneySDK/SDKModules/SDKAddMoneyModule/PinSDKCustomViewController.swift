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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.textFieldPin.title = "Enter Pin"
        self.textFieldPin.state = .normal
        self.textFieldPin.textFieldFont = AppFont.appRegular(size: .h7)
        self.textFieldPin.textFieldTextColor = AppColor.eAnd_Black_80
        self.textFieldPin.entryType = .numberPad
        self.textFieldPin.state = .normal
        
        self.buttonVerify.setTitle("Verify", for: .normal)
        self.buttonVerify.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
        IQKeyboardManager.shared.enable = true
        
        if SDKColors.shared.accessToken == nil {
            self.getToken()
        } else {
            sendOTP()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Loader.shared.showFullScreen()
    }
    
    func getToken() {
        var request = URLRequest(url: URL(string: "https://enmoneyapim.azure-api.net/gettoken/v1/token?authorization=Basic%20bW9iaWxlLWZlOnBhc3N3b3JkMTIz")!)
        request.method = HTTPMethod.post
        request.headers.add(HTTPHeader(name: "custom_header", value: "pre_prod"))
        request.headers.add(HTTPHeader(name: "client_id",   value: SDKColors.shared.clientID!))
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                self?.parseData(data)
            }
        }.resume()
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
        }
    }
    
    @IBAction func actionVerifyPin(_ sender: BaseButton) {
        print(#function)
        if !(textFieldPin.text.isEmpty) {
            self.loginUser(pin: textFieldPin.text)
        }
    }
    
    func routToSelectCard() {
        let vc = AddMoneyRouter.setupModule()
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: true)
    }
    
    func loginUser(pin: String) {
        Task {
            do {
                Loader.shared.showFullScreen()
                let request = LoginRequestModel()
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
                request.identity = SDKColors.shared.msisdn
                
                if GlobalData.shared.isDeviceChanged && GlobalData.shared.msisdnStatusData?.oldDeviceId != nil {
                    request.oldDeviceId = GlobalData.shared.msisdnStatusData?.oldDeviceId ?? ""
                }else{
                    request.oldDeviceId = ""
                }
                
                let loginModel:LoginResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.login(param: request))
                print(loginModel ?? "")
                await MainActor.run {
                    if loginModel != nil {
//                        output?.loginRequestResponse(response: loginModel!)
                        // Show cards screen
                        Loader.shared.hideFullScreen()
                        UserDefaultHelper.userLoginPin = pin
                        routToSelectCard()
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
//                    output?.loginRequestResponseError(error:error)
                    // Show error
                    Loader.shared.hideFullScreen()
                    
                }
                
            }
        }
    }
    
    func sendOTP() {
        Task {
            do {
                let request = VerifyMobileNumberOtpSendRequestModel(isSingleAccount: true,
                                                                    msisdn: SDKColors.shared.msisdn!,
                                                                    flowName: "AddMoney")
                
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
                Loader.shared.hideFullScreen()
            }
        }
    }
}
