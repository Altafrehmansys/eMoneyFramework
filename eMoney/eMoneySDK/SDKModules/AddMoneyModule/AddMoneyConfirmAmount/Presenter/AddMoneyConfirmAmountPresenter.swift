//
//  AddMoneyConfirmAmountPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation

class AddMoneyConfirmAmountPresenter {

    // MARK: Properties
    weak var view: AddMoneyConfirmAmountViewProtocol?
    var router: AddMoneyConfirmAmountRouterProtocol?
    var interactor: AddMoneyConfirmAmountInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions?
    var isCollapsed: Bool = true
    
    var title: String = ""
    var subtitle: String = ""
    var logo: String = ""
    var amount: String = ""
    
    
    private var paymentIntentId = ""
    var selectedLeanBank: BankAccountsListResponseModel.PaymentSources?
    var selectedDebitCard: CardResponseObjectModel.CardResponseObjectDataModel?
    var selectedAccountId: String?
    var disclaimerMessage: String? = nil
    
    var currentFlow: CashInFlowType = .none
    
    // Computed Properties
    var amountString: String {
        get {
            self.amount.removeAll { $0 == "," }
            let scanner = Scanner(string: self.amount)
            scanner.scanUpToCharacters(from: CharacterSet.decimalDigits, into: nil)
            var amount: Float = 0
            scanner.scanFloat(&amount)
            return String(amount)
        }
    }
}

extension AddMoneyConfirmAmountPresenter: AddMoneyConfirmAmountPresenterProtocol {
    func loadData() {
        view?.setupUI()
        
        self.setupCellActions()
        self.makeDataSource()
    }
}

// MARK: - Prepare Data source
extension AddMoneyConfirmAmountPresenter {
    func makeDataSource() {
        self.dataSource.removeAll()
        
        if isCollapsed {
            self.dataSource = self.collapsedDataSource()
        } else {
            self.dataSource = self.expandedDataSource()
        }
        view?.reloadData()
    }
    
    private func collapsedDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        let singleLabelCell = GenericSingleLabelCellModel(content: "Transaction ID 34560981",
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 20,
                                                          bottomSpace: 16)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func expandedDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        let singleLabelCell = GenericSingleLabelCellModel(content: "Transaction ID 34560981",
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 20)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.makeDataSource()
            }
        })
    }
}

// MARK: - Navigations
extension AddMoneyConfirmAmountPresenter {
    func goBack() {
        self.router?.go(to: .back)
    }
    
    func loadOTPScreen(msisdn: String, addingText:String, amount: String, toTitle: String){
        self.router?.go(to: .loadOTPScreen(msisdn: msisdn, addingText: addingText, amount: amount, toTitle: toTitle))
    }
    
    func nextButtonTapped() {
        switch currentFlow {
        case .lean:
            getPaymentIntent()
            
        case .bankAcount:
            navigateToPaymentGateway()
            
        case .debitCard:
            initializeCardPayment()
            
        default:
            break
        }
    }
}

// MARK: - Initialize UAEPGS Flow
extension AddMoneyConfirmAmountPresenter {
    
    private func navigateToPaymentGateway() {
        
        Loader.shared.showFullScreen()
        let request = UaePgsRequestModel(amount: self.amountString, isDebitCard: false)
        interactor?.getPaymentGatewayDetails(request: request)
    }
}

// MARK: - Debit card flow
extension AddMoneyConfirmAmountPresenter {
    
    private func initializeCardPayment() {
        if let selectedDebitCard {
            Loader.shared.showFullScreen()
            interactor?.initializeCardPayment(with: selectedDebitCard, and: amountString)
        }
    }
}

// MARK: - Lean Flow
extension AddMoneyConfirmAmountPresenter {
    
    private func getPaymentIntent() {
        guard let bank = selectedLeanBank, let account = bank.accounts?.first(where: {$0.accountId == self.selectedAccountId}) else {
            debugPrint("Selected bank or account not found")
            return
        }
        
        let paymentIntentReq = PaymentIntentRequestModel(
            accountID: account.accountId ?? "",
            accountName: account.accountName ?? "",
            accountNumber: account.accountNumber ?? "",
            amount: Double(amountString) ?? 0.0,
            currency: account.currency ?? "",
            eWalletBalance: String(account.accountBalance ?? 0),
            iban: account.iban ?? "",
            bankIdentifier: bank.bankIdentifier ?? ""
        )
        
        Loader.shared.showFullScreen()
        interactor?.getPaymentIntetnt(request: paymentIntentReq)
    }
}

// MARK: - Add Money AddAmount Interactor Output Protocol
extension AddMoneyConfirmAmountPresenter: AddMoneyConfirmAmountInteractorOutputProtocol {

    func onPaymentIntentResponse(response: PaymentIntentResponseModel) {
        LeanSDKManager.shared.setupLeanSDK()
        LeanSDKManager.shared.delegate = self
        
        guard let accountId = self.selectedAccountId, let paymentIntent = response.data?.paymentIntentID else {
            debugPrint("Account id not found")
            return
        }
        Loader.shared.hideFullScreen()
        self.paymentIntentId = paymentIntent
        self.router?.navigateToPayLeanSDK(paymentIntent: paymentIntent, selectedSouceBankID: accountId)
    }
    
    func onFetchPaymentIntentError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
    
    func onPaymentGatewayDetails(response: UaePgsResponseModel) {
        Loader.shared.hideFullScreen()
        if let data = response.data, let portalUrl = data.paymentPortalUrl, !portalUrl.isEmpty, let transactionId = data.transactionId, !transactionId.isEmpty {
            if let url = URL(string: portalUrl) {
                var request = URLRequest(url: url)
                let body = String(format: "%@=%@", "transactionId", transactionId)
                request.setValue("pre_prod", forHTTPHeaderField: "custom_header")
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = body.data(using: .utf8)
                
                let input = AddMoneyWebViewRouter.Input(request: request, currentFlow: self.currentFlow)
                self.router?.go(to: .loadWebViewWith(input: input))
            }
        }
    }
    
    func onPaymentGatewayDetails(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
    
    func onCardPaymentInitialized(response: InitializeCardPaymentResponseModel) {
        debugPrint("got response")
        Loader.shared.hideFullScreen()
        
        if let data = response.data, let portalUrl = data.url, !portalUrl.isEmpty {
            if let url = URL(string: portalUrl) {
                var request = URLRequest(url: url)
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET"
                
                let input = AddMoneyWebViewRouter.Input(request: request, currentFlow: self.currentFlow, addedAmount: self.amountString, sourceTitle: (self.title) + " " + (self.selectedDebitCard?.maskedCardNumber ?? ""))
                self.router?.go(to: .loadWebViewWith(input: input))
            }
        }
    }
    
    func onCardPaymentInitialization(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
    
    func onPaymentIntentStatus(response: PaymentIntentStatusResponseModel) {
        Loader.shared.hideFullScreen()
        let input = AddMoneySuccessRouter.Input(title: Strings.AddMoney.transferInitiatedSuccessfully,
                                                subtitle: Strings.AddMoney.youWillBeNotifiedWhenTransferArrived,
                                                switchTitle: Strings.AddMoney.activateAddMoney,
                                                amount: amount,
                                                transactionID: response.data?.bankTransactionReference ?? "",
                                                currentFlow: currentFlow,
                                                selectedLeanBank: self.selectedLeanBank,
                                                selectedLeanAccount: self.selectedLeanBank?.accounts?.first(where: {$0.accountId == self.selectedAccountId}))
        self.router?.go(to: .loadSuccessScreen(input: input))
    }
    
    func onPaymentIntentStatus(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
}


extension AddMoneyConfirmAmountPresenter : LeanSDKManagerDelegate {
    func dismissWithSuccess(status: LeanSDKStatusEnum) {
        if status == .Success {
            Loader.shared.showFullScreen()
            self.interactor?.updatePaymentIntentStatus(with: self.paymentIntentId)
        }
    }
    
    func dismissWithError(status: LeanSDKStatusEnum) {
        switch status {
        case .Cancelled:
            router?.go(to: .alternateFlow)
        case .Error:
            Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong,
                                       message: Strings.AddMoney.couldNotReachYourBankDescription,
                                       actionBtnTitle: Strings.Generic.tryAgain,
                                       secondryBtnTitle: Strings.AddMoney.tryUsingAnotherMethod,
                                       delegate: self)
        default:
            break
        }
    }
}

// MARK: - Delegate Methods
extension AddMoneyConfirmAmountPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        guard let accountId = self.selectedAccountId else {
            debugPrint("Account id not found")
            return
        }
        self.router?.navigateToPayLeanSDK(paymentIntent: paymentIntentId, selectedSouceBankID: accountId)
    }
    
    func secondryBtnTapped() {
        self.router?.go(to: .loadLeanErrorTray)
    }
}
