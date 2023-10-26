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
                GlobalData.shared.msisdn = SDKColors.shared.msisdn
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
                
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
