//
//  RegistrationMethodsInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

final class RegistrationMethodsInteractor: RegistrationMethodsInteractorProtocol {
    
    // MARK: - Attributes
    weak var output: RegistrationMethodsInteractorOutputProtocol?
    
    
    func lookupApiCalltoServer(lookupType: String) {
        Task {
            do {
                let request = RegistrationMethodsRequestModel(lookupType: lookupType)
              
                let data:LookupRegistrationMethodsModel? = try await ApiManager.shared.execute(OnboardingApiRouter.lookUp(param: request))
                await MainActor.run {
                    output?.lookupApiCallResponse(response: data)
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    print(error)
                    output?.lookupApiCallError(error: error)
                }
                
            }
        }
    }
}
