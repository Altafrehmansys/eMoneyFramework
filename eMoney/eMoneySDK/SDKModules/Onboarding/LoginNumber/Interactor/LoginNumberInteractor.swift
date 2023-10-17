//
//  LoginNumberInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/05/2023.
//  
//

import Foundation

class LoginNumberInteractor {
    // MARK: Properties

    weak var output: LoginNumberInteractorOutputProtocol?

}

extension LoginNumberInteractor: LoginNumberInteractorProtocol {
    //Implement your services
    
    func checkMobileNumberStatusFromServer(msisdn: String) {
        Task {
            do {
                
                let request = RegisterMobileNumberRequestModel(msisdn:msisdn)
                
                let response:RegisterMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.registerationStatus(param: request))
                print(response ?? "")
                await MainActor.run {
                    if response != nil {
                        GlobalData.shared.status = response?.data?.status
                        output?.registerStatusRequestResponse(response:response!)
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.registerStatusRequestResponseError(error:error)
                }
                
            }
        }
    }
}

