//
//  AddMoneyConfirmAmountInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation

class AddMoneyConfirmAmountInteractor {
    // MARK: Properties

    weak var output: AddMoneyConfirmAmountInteractorOutputProtocol?

}

extension AddMoneyConfirmAmountInteractor: AddMoneyConfirmAmountInteractorProtocol {

    func getPaymentIntetnt(request: PaymentIntentRequestModel) {
        Task{
            do {
                let response: PaymentIntentResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.createPaymentIntent(param: request))
                await MainActor.run{
                    if let response {
                        output?.onPaymentIntentResponse(response: response)
                    }
                }
            }
            catch let error as AppError {
                await MainActor.run{
                    output?.onFetchPaymentIntentError(error: error)
                }
            }
        }
    }
    
    func updatePaymentIntentStatus(with paymentIntentID: String) {
        Task {
            do {
                let response: PaymentIntentStatusResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.updateIntentStatus(paymentIntentID: paymentIntentID))
                await MainActor.run{
                    if let response {
                        output?.onPaymentIntentStatus(response: response)
                    }
                }
            }
            catch let error as AppError {
                await MainActor.run{
                    output?.onPaymentIntentStatus(error: error)
                }
            }
        }
    }
}

// MARK: - Get UAE PGS
extension AddMoneyConfirmAmountInteractor {
    func getPaymentGatewayDetails(request: UaePgsRequestModel) {
        Task{
            do {
                let response: UaePgsResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.paymentGateway(param: request))
                await MainActor.run {
                    if let response {
                        output?.onPaymentGatewayDetails(response: response)
                    }
                }
            }
            catch let error as AppError {
                await MainActor.run {
                    output?.onPaymentGatewayDetails(error: error)
                }
            }
        }
    }
}

// MARK: - Initialize Card Payment
extension AddMoneyConfirmAmountInteractor {
    func initializeCardPayment(with card: CardResponseObjectModel.CardResponseObjectDataModel, and amount: String) {
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
                request.amount = amount
                request.pin = UserDefaultHelper.userLoginPin
                
                let response: InitializeCardPaymentResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.initializeCardPayment(param: request))
                await MainActor.run {
                    if let response {
                        output?.onCardPaymentInitialized(response: response)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onCardPaymentInitialization(error: error)
                }
            }
        }
    }
}
