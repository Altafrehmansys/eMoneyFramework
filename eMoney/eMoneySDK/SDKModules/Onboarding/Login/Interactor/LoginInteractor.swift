//
//  LoginInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class LoginInteractor {
    // MARK: Properties

    weak var output: LoginInteractorOutputProtocol?

}

extension LoginInteractor: LoginInteractorProtocol {
    //Implement your services
    func sendLoginPinToServer(pin: String) {
        Task {
            do {
                let request = LoginRequestModel()
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
                if GlobalData.shared.isDeviceChanged && GlobalData.shared.msisdnStatusData?.oldDeviceId != nil {
                    request.oldDeviceId = GlobalData.shared.msisdnStatusData?.oldDeviceId ?? ""
                }else{
                    request.oldDeviceId = ""
                }
                
                let loginModel:LoginResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.login(param: request))
                print(loginModel ?? "")
                await MainActor.run {
                    if loginModel != nil {
                        UserDefaultHelper.userLoginPin = pin
                        output?.loginRequestResponse(response: loginModel!)
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.loginRequestResponseError(error:error)
                }
                
            }
        }
    }
  
}
