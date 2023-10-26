//
//  ReEnterPinInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation

class ReEnterPinInteractor {
    // MARK: Properties

    weak var output: ReEnterPinInteractorOutputProtocol?

}

extension ReEnterPinInteractor: ReEnterPinInteractorProtocol {
    func callResetApi(request: ResetPinRequestModel) {
        Task{
            do {
                let data:ResetPinResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.resetPin(param: request))
                await MainActor.run{
                    output?.resetPinResponse(response:data!)
                }
            } catch let error as AppError {
                print(error.errorDescription)
                await MainActor.run{
                    output?.onResetError(error:error)
                }
            }
        }
    }
    
    //Implement your services
    
    func registerUser(request:RegistrationRequestModel) {
        Task{
            do {
                let data:RegistrationResponseModel? = try await ApiManager.shared.executeMultipart(OnboardingApiRouter.registerUser(param: request))
                await MainActor.run{
                    output?.onRegisterUserResponse(response:data)
                }
            } catch let error as AppError {
                print(error.errorDescription)
                await MainActor.run{
                    output?.onRegisterUserError(error:error)
                }
            }
        }
    }
    
    func loginUser(pin: String) {
        Task {
            do {
                let request = LoginRequestModel()
                let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
                request.pin = val
                request.isNewLogin = true
                
                let loginModel:LoginResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.login(param: request))
                print(loginModel ?? "")
                await MainActor.run {
                    if loginModel != nil {
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
