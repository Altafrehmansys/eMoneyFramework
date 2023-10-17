//
//  SelectCardInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation

class SelectCardInteractor {
    // MARK: Properties

    weak var output: SelectCardInteractorOutputProtocol?

}

extension SelectCardInteractor: SelectCardInteractorProtocol {
    //Implement your services
    func callCardColorApiToServer(model: SelectCardRequestModel) {
        Task {
            do {
                let request = model
                let loginModel:BaseResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.cardColor(param: request))
                print(loginModel ?? "")
                await MainActor.run {
                    if loginModel != nil {
                        output?.selectCardRequestResponse(response: loginModel!)
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.selectCardRequestResponseError(error:error)
                }
                
            }
        }
    }
}
