//
//  RegisterEmailInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation

class RegisterEmailInteractor {
    // MARK: Properties

    weak var output: RegisterEmailInteractorOutputProtocol?

}

extension RegisterEmailInteractor: RegisterEmailInteractorProtocol {
    //Implement your services
    func verifyEmail(email: String) {
        Task {
            do {
                let response:BaseResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.verifyEmail(email: email))
                await MainActor.run {
                    output?.verifyEmailResponse(response: response)
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.verifyEmailError(error:error)
                }
                
            }
        }
    }
}
