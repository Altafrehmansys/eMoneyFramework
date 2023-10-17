//
//  RegisterMobileNumberInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

class RegisterMobileNumberInteractor {
    // MARK: Properties
    weak var output: RegisterMobileNumberInteractorOutputProtocol?
}

extension RegisterMobileNumberInteractor: RegisterMobileNumberInteractorProtocol {
    //Implement your services
    func checkMobileNumberStatusFromServer(msisdn: String) {
        Task {
            do {
                let request = RegisterMobileNumberRequestModel(msisdn:msisdn,identity: msisdn)
                
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
