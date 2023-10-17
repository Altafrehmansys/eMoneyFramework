//
//  TermsConditionsInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class TermsConditionsInteractor {
    // MARK: Properties
    
    weak var output: TermsConditionsInteractorOutputProtocol?
}

extension TermsConditionsInteractor: TermsConditionsInteractorProtocol {
    //Implement your services
    
    func getTermsConditionFromServer(type: String) {
        Task {
            do {
                let request = TermsConditionsRequestModel(key:type)
                let termsModel:TermsConditionsResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.termsAndCondition(param: request))
                print(termsModel ?? "")
                await MainActor.run {
                    if termsModel != nil {
                        output?.termsConditonRequestResponse(response: termsModel!)
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.termsConditonRequestResponseError(error:error)
                }
                
            }
        }
        
    }
}
