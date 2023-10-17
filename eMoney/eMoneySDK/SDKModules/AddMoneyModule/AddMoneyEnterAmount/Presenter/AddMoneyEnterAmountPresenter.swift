//
//  AddMoneyEnterAmountPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/04/2023.
//  
//

import Foundation

class AddMoneyEnterAmountPresenter {

    // MARK: Properties
    weak var view: AddMoneyEnterAmountViewProtocol?
    var router: AddMoneyEnterAmountRouterProtocol?
    var interactor: AddMoneyEnterAmountInteractorProtocol?
    
    var title: String = ""
    var subtitle: String = ""
    var logo: String = ""
    var currentFlow: CashInFlowType = .none
    var selectedLeanBank: BankAccountsListResponseModel.PaymentSources?
    var selectedDebitCard: CardResponseObjectModel.CardResponseObjectDataModel?
    var selectedAccountId: String?
    
    private var sessionId: String?
    private var transactionId: String?
    private var customerName: String?
    private var storeName: String?
    private var amountString = ""
}

extension AddMoneyEnterAmountPresenter: AddMoneyEnterAmountPresenterProtocol {
    func loadData() {
        view?.setupUI()
    }
}

// MARK: - Navigations
extension AddMoneyEnterAmountPresenter {
    func goBack() {
        if currentFlow == .bankAcount {
            self.router?.go(to: .back)
        } else {
            self.router?.go(to: .backToRoot)
        }
    }
    
    func confirmAmount(with amount: String) {
        let input = AddMoneyConfirmAmountRouter.Input(title: self.title,
                                                      subtitle: self.subtitle,
                                                      logo: self.logo,
                                                      amount: amount,
                                                      flowType: currentFlow,
                                                      selectedLeanBank: self.selectedLeanBank,
                                                      selectedAccountId: self.selectedAccountId,
                                                      selectedDebitCard: self.selectedDebitCard)
        self.router?.go(to: .confirmAmount(input: input))
    }
    
    func fundsAddedScreen(title: String, subtitle: String, switchTitle: String, amount: String, transactionID: String ){
        let input = AddMoneySuccessRouter.Input(title: title, subtitle: subtitle, switchTitle: switchTitle, amount: amount, transactionID: transactionID, currentFlow: self.currentFlow)
        self.router?.go(to: .fundsAddedScreen(input: input))
    }
}


// MARK: - Apple Pay Flow Configuration
extension AddMoneyEnterAmountPresenter {
    
    func initiatApplePayFlow(with amount: String) {
        self.amountString = amount
        Loader.shared.showFullScreen()
        interactor?.getCardsListRequest()
    }
    
    func submitPaymentRequest(paymentData: [AnyHashable : Any]) {
        Loader.shared.showFullScreen()
        interactor?.submitPaymentRequest(paymentData: paymentData, transactionID: self.transactionId ?? "", sessionID: self.sessionId ?? "", customerName: self.customerName ?? "", storeName: self.storeName ?? "")
    }
}

// MARK: - AddMoney EnterAmount Interactor Output Protocol
extension AddMoneyEnterAmountPresenter: AddMoneyEnterAmountInteractorOutputProtocol {
    func on(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
    
    func onCardsList(response: CardResponseObjectModel) {
        if let cardsList = response.data, let card = cardsList.first(where: {$0.brand?.lowercased() == "apple"}) {
            self.interactor?.initializeCardPayment(with: card, and: amountString)
        } else {
            Loader.shared.hideFullScreen()
        }
    }
    
    func onCardPayment(response: InitializeCardPaymentResponseModel) {
        if let data = response.data {
            self.transactionId = data.epgTransactionId
            self.sessionId = data.epgSessionId
            self.customerName = data.epgCustomerName
            self.storeName = data.epgStore
            self.interactor?.createWalletSession(transactionID: self.transactionId ?? "", sessionID: self.sessionId ?? "", customer: self.customerName ?? "")
        }
    }
    
    func onCreateWalletSession(response: CreateWalletSessionModel) {
        debugPrint("Session created")
        DispatchQueue.main.async {
            Loader.shared.hideFullScreen()
        }
        view?.tapApplePay()
    }
    
    func onCreateWalletSession(error: Error) {
        DispatchQueue.main.async {
            Loader.shared.hideFullScreen()
            Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.localizedDescription)
        }
    }
    
    func onWalletFinalizeSuccess(response: FinalizeCardPaymentResponseModel) {
        Loader.shared.hideFullScreen()
        self.fundsAddedScreen(title: Strings.AddMoney.fundsAddedSuccessfully, subtitle: "", switchTitle: Strings.AddMoney.enableAutoAddMoney, amount: amountString, transactionID: self.transactionId ?? "")
    }
    
    func onSubmitPaymentSuccess(response: CreateWalletSessionModel) {
        interactor?.finalizeCardPayment(transactionID: transactionId ?? "")
    }
    
    func onSubmitPaymentError(error: Error) {
        debugPrint("Got error" + error.localizedDescription)
        DispatchQueue.main.async {
            Loader.shared.hideFullScreen()
            Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.localizedDescription)
        }
    }
}
