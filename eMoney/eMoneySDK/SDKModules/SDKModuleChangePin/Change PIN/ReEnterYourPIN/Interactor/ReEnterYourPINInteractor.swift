//
//  ReEnterYourPINInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

class ReEnterYourPINInteractor {
    // MARK: Properties

    weak var output: ReEnterYourPINInteractorOutputProtocol?

}

extension ReEnterYourPINInteractor: ReEnterYourPINInteractorProtocol {
    //Implement your services
    
    func changePinRequest(request:ReEnterYourPINRequestModel) {
        Task {
            do {
                let changePinModel:ReEnterYourPINResponseModel? = try await ApiManager.shared.execute(ChangePinApiRouter.changePin(param: request))

                await MainActor.run {
                    if changePinModel != nil {
                        output?.onChangePinResponse(response: changePinModel)
                    }
                }
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.onChangePinError(error: error)
                }
            }
        }
    }
}
