//
//  AddMoneyEnterAmountContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/04/2023.
//  
//

import Foundation

protocol AddMoneyEnterAmountViewProtocol: ViperView {
    func setupUI()
    func tapApplePay()
}

protocol AddMoneyEnterAmountPresenterProtocol: ViperPresenter {
    var title: String { get set }
    var subtitle: String { get set }
    var logo: String { get set }
    var currentFlow: CashInFlowType { get set }
    var selectedLeanBank: BankAccountsListResponseModel.PaymentSources? { get set }

    func loadData()
    func goBack()
    func initiatApplePayFlow(with amount: String)
    func confirmAmount(with amount: String)
    
    func fundsAddedScreen(title: String, subtitle: String, switchTitle: String, amount: String, transactionID: String)
    func submitPaymentRequest(paymentData: [AnyHashable: Any])
}

protocol AddMoneyEnterAmountInteractorProtocol: ViperInteractor {
    func getCardsListRequest()
    func initializeCardPayment(with card: CardResponseObjectModel.CardResponseObjectDataModel, and amount: String)
    func createWalletSession(transactionID: String, sessionID: String, customer: String)
    func submitPaymentRequest(paymentData: [AnyHashable: Any], transactionID: String, sessionID: String, customerName: String, storeName: String)
    func finalizeCardPayment(transactionID: String)
}

protocol AddMoneyEnterAmountInteractorOutputProtocol: AnyObject {
    func onCardsList(response: CardResponseObjectModel)
    func onCardPayment(response: InitializeCardPaymentResponseModel)
    func onWalletFinalizeSuccess(response: FinalizeCardPaymentResponseModel)
    
    func onCreateWalletSession(response: CreateWalletSessionModel)
    func onCreateWalletSession(error: Error)
    
    func onSubmitPaymentSuccess(response: CreateWalletSessionModel)
    func onSubmitPaymentError(error: Error)
    
    func on(error: AppError)
}

protocol AddMoneyEnterAmountRouterProtocol: ViperRouter {
    func go(to route: AddMoneyEnterAmountRouter.Route)
}
