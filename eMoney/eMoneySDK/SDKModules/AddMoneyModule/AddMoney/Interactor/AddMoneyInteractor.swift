//
//  AddMoneyInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation

class AddMoneyInteractor {
    // MARK: Properties

    weak var output: AddMoneyInteractorOutputProtocol?

}

extension AddMoneyInteractor: AddMoneyInteractorProtocol {
    
    func getAddMoneyMetaData() {
        Task {
            do {
                let response: AddMoneyMetaDataResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.addMoneyMetaData)
                await MainActor.run {
                    output?.onMetaData(Response: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onMetaData(Error: error)
                }
            }
        }
    }
    
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
    
    func getCardsListRequest() {
        Task {
            do {
                var request = WalletRegistrationRequestModel()
                request.pin = UserDefaultHelper.userLoginPin ?? ""
                request.identity = SDKColors.shared.msisdn
                let response: CardResponseObjectModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.listCards(param: request))
                await MainActor.run {
                    if let response {
                        output?.onCardsList(Response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onCardsList(Error: error)
                }
            }
        }
    }
}

// MARK: - Debit Card
extension AddMoneyInteractor {
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
