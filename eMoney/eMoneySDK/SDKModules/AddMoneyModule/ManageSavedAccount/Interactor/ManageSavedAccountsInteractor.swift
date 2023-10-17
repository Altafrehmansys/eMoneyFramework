//
//  ManageSavedAccountsInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/05/2023.
//  
//

import Foundation

class ManageSavedAccountsInteractor {
    // MARK: Properties

    weak var output: ManageSavedAccountsInteractorOutputProtocol?

}

extension ManageSavedAccountsInteractor: ManageSavedAccountsInteractorProtocol {
    
    func removeBankAccount(with sourceId: String) {
        Task{
            do {
                let response: BankAccountsListResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.removeBankAccount(sourceId: sourceId))
                await MainActor.run {
                    output?.onRemoveBankAccount(Response: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onRemoveBankAccount(Error: error)
                }
            }
        }
    }
    
    func removeDebitCard(with card: CardResponseObjectModel.CardResponseObjectDataModel) {
        Task {
            do {
                var request = InitializeCardPaymentRequestModel()
                request.cardTitle = card.cardTitle
                request.cardNumber = card.cardNumber
                request.maskedCardNumber = card.maskedCardNumber
                request.subtype = card.subtype
                request.status = card.status
                request.issuer = card.issuer
                request.brand = card.brand
                request.providerName = card.providerName
                request.providerUserName = card.providerUserName
                request.reason = card.reason
                request.pin = UserDefaultHelper.userLoginPin ?? ""
                
                let response: InitializeCardPaymentResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.removeCard(param: request))
                await MainActor.run {
                    if let response {
                        output?.onDebitCardRemove(Response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onDebitCardRemove(Error: error)
                }
            }
        }
    }
}
