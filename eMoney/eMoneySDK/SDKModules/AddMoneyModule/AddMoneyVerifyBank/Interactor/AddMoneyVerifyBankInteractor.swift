//
//  AddMoneyVerifyBankInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//  
//

import Foundation

class AddMoneyVerifyBankInteractor {
    // MARK: Properties

    weak var output: AddMoneyVerifyBankInteractorOutputProtocol?

}

extension AddMoneyVerifyBankInteractor: AddMoneyVerifyBankInteractorProtocol {
    func verifyIbanNumber(iban: String) {
        Task {
            do {
                let response: BaseResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.verify(iban: iban))
                await MainActor.run {
                    output?.onIbanVerification(response: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onIbanVerification(error: error)
                }
            }
        }
    }
}
