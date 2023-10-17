//
//  AddMoneySelectBankInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 25/04/2023.
//  
//

import Foundation

class AddMoneySelectBankInteractor {
    // MARK: Properties
    weak var output: AddMoneySelectBankInteractorOutputProtocol?
}

extension AddMoneySelectBankInteractor: AddMoneySelectBankInteractorProtocol {
    func getBankAccountsList() {
        Task {
            do {
                let response: BankAccountsListResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.getBankAccountsList)
                await MainActor.run {
                    output?.onBankAccountsList(Response: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onBankAccountsList(Error: error)
                }
            }
        }
    }
}
