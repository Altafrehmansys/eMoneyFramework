//
//  AlternateFlowForLeanInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 22/06/2023.
//  
//

import Foundation

class AlternateFlowForLeanInteractor {
    // MARK: Properties

    weak var output: AlternateFlowForLeanInteractorOutputProtocol?

}

extension AlternateFlowForLeanInteractor: AlternateFlowForLeanInteractorProtocol {
    func getOptionsList() {
        Task {
            do {
                let response: AddMoneyOptionsListResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.getOptionsList(typeIdentifier: "ADD_MONEY_ALT"))
                await MainActor.run {
                    output?.onOptionsList(Response: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onOptionsList(Error: error)
                }
            }
        }
    }
}

// MARK: - Debit Card
extension AlternateFlowForLeanInteractor {
    func initializeAddCard() {
        Task {
            do {
                let response: AddDebitCardResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.initializeAddCard)
                await MainActor.run {
                    if let response {
                        output?.onAddCard(Response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onAddCard(Error: error)
                }
            }
        }
    }
}
