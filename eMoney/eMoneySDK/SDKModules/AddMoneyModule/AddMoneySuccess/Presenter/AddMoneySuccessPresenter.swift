//
//  AddMoneySuccessPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation

class AddMoneySuccessPresenter {

    // MARK: Properties
    weak var view: AddMoneySuccessViewProtocol?
    var router: AddMoneySuccessRouterProtocol?
    var interactor: AddMoneySuccessInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions?
    var isCollapsed: Bool = true
    
    var title: String = ""
    var subtitle: String = ""
    var switchTitle: String = ""
    var amount: String = ""
    var transactionID: String = ""
    var currentFlow: CashInFlowType = .none
    
    var selectedLeanBank: BankAccountsListResponseModel.PaymentSources?
    var selectedLeanAccount: BankAccountsListResponseModel.Accounts?
    var cashInWithBank: FundInResponseModel? = nil
    
    private var shareableContent: [String: String] = [:]
}

extension AddMoneySuccessPresenter: AddMoneySuccessPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        setupCellActions()
        
        self.makeDataSource()
    }
}

// MARK: - Prepare Data source
extension AddMoneySuccessPresenter {
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
        switch currentFlow {
        case .lean:
            let _ = expandedLeanDataSource()
            return collapsedLeanDataSource()
        case .bankAcount, .debitCard:
            let _ = expandedBankDataSource()
            return collapsedBankDataSource()
        case .applePay:
            let _ = expandedApplePayDataSource()
            return collapsedApplePayDataSource()
        default:
            return []
        }
    }
    
    private func expandedDataSource() -> [StandardCellModel] {
        switch currentFlow {
        case .lean:
            return expandedLeanDataSource()
        case .bankAcount, .debitCard:
            return expandedBankDataSource()
        case .applePay:
            return expandedApplePayDataSource()
        default:
            return []
        }
    }
}

// MARK: - Data Source for Lean
extension AddMoneySuccessPresenter {
    private func collapsedLeanDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        let content = Strings.AddMoney.transactionId + " " + transactionID
        let singleLabelCell = GenericSingleLabelCellModel(content: content,
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 24,
                                                          bottomSpace: 16)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func expandedLeanDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        // Emirates NBD **** 3702
        let bankName = (self.selectedLeanBank?.bankName ?? "") + " " + (self.selectedLeanAccount?.maskedAccountNumber ?? "")
        let methodCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.method, value: bankName)
        dataSource.append(methodCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        // AED 10.00
        let amount = self.amount.lowercased().replace(string: (Strings.Generic.currency.lowercased() + " "), replacement: "")
        let amountInDouble = (Double(amount) ?? 0.0)
        
        let amountAddedCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.amountAdded, value: (Strings.Generic.currency + " " + amountInDouble.formattedAmountWithComma))
        dataSource.append(amountAddedCellModel)
        
        
        // AED 359.50
        let totalBalance = (GlobalData.shared.availableBalance?.balance ?? 0.0) + amountInDouble
        let walletBalance = Strings.Generic.currency + " " + totalBalance.formattedAmountWithComma
        
        let walletBalanceCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.newWalletBalance, value: walletBalance)
        dataSource.append(walletBalanceCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        // 34560981
        let transactionIdCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.transactionId, value: transactionID)
        dataSource.append(transactionIdCellModel)
        
        // Dec 23, 2023 at 09:41 am
        let dateCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.date, value: Date().formate(with: .fullDateTime))
        dataSource.append(dateCellModel)
        
        self.shareableContent[Strings.AddMoney.method] = bankName
        self.shareableContent[Strings.AddMoney.amountAdded] = (Strings.Generic.currency + " " + amountInDouble.formattedAmountWithComma)
        self.shareableContent[Strings.AddMoney.newWalletBalance] = walletBalance
        self.shareableContent[Strings.AddMoney.transactionId] = transactionID
        self.shareableContent[Strings.AddMoney.date] = Date().formate(with: .fullDateTime)
        
        return dataSource
    }
}

// MARK: - Data source for Bank account
extension AddMoneySuccessPresenter {
    private func collapsedBankDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        let transactionID = cashInWithBank?.paymentTransactionID ?? ""
        let content = Strings.AddMoney.transactionId + " " + transactionID
        let singleLabelCell = GenericSingleLabelCellModel(content: content,
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 24,
                                                          bottomSpace: 16)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func expandedBankDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        var bankName = cashInWithBank?.paymentBANKNAME ?? ""
        let methodCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.method, value: bankName)
        dataSource.append(methodCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        // AED 10.00
        let amount = (cashInWithBank?.paymentAMOUNT ?? "").lowercased().replace(string: (Strings.Generic.currency.lowercased() + " "), replacement: "")
        let amountInDouble = (Double(amount) ?? 0.0)
        
        let amountAddedCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.amountAdded, value: Strings.Generic.currency + " " + amountInDouble.formattedAmountWithComma)
        dataSource.append(amountAddedCellModel)
        
        
        let newWalletBalance = (Double(cashInWithBank?.paymentBALANCE ?? "") ?? 0.0).formattedAmountWithComma
        let walletBalance = Strings.Generic.currency + " " + newWalletBalance
        let walletBalanceCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.newWalletBalance, value: walletBalance)
        dataSource.append(walletBalanceCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        let transactionID = cashInWithBank?.paymentTransactionID ?? ""
        let transactionIdCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.transactionId, value: transactionID)
        dataSource.append(transactionIdCellModel)
        
        let dateCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.date, value: Date().formate(with: .fullDateTime))
        dataSource.append(dateCellModel)
        
        
        self.shareableContent[Strings.AddMoney.method] = bankName
        self.shareableContent[Strings.AddMoney.amountAdded] = (Strings.Generic.currency + " " + amountInDouble.formattedAmountWithComma)
        self.shareableContent[Strings.AddMoney.newWalletBalance] = walletBalance
        self.shareableContent[Strings.AddMoney.transactionId] = transactionID
        self.shareableContent[Strings.AddMoney.date] = Date().formate(with: .fullDateTime)
        
        
        return dataSource
    }
}

// MARK: - Data source for Apple pay
extension AddMoneySuccessPresenter {
    private func collapsedApplePayDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        let content = Strings.AddMoney.transactionId + " " + transactionID
        let singleLabelCell = GenericSingleLabelCellModel(content: content,
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 24,
                                                          bottomSpace: 16)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func expandedApplePayDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.transactionDetails, isCollapsed: self.isCollapsed, topSpace: 16)
        dataSource.append(titleCellModel)
        
        
        let bankName = "via Apple Pay"
        let methodCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.method, value: bankName)
        dataSource.append(methodCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        let amount = self.amount.lowercased().replace(string: (Strings.Generic.currency.lowercased() + " "), replacement: "")
        let amountBalance = Strings.Generic.currency + " " + (Double(amount) ?? 0.0).formattedAmountWithComma
        let amountAddedCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.amountAdded, value: amountBalance)
        dataSource.append(amountAddedCellModel)
        
        let totalBalance = (GlobalData.shared.availableBalance?.balance ?? 0.0) + (Double(amount) ?? 0.0)
        
        let walletBalance = Strings.Generic.currency + " " + totalBalance.formattedAmountWithComma
        
        let walletBalanceCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.newWalletBalance, value: walletBalance)
        dataSource.append(walletBalanceCellModel)
        
        dataSource.append(GenericDividerTableViewCellModel())
        
        let transactionIdCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.transactionId, value: transactionID)
        dataSource.append(transactionIdCellModel)
        
        let dateCellModel = KeyValueTableViewCellModel(key: Strings.AddMoney.date, value: Date().formate(with: .fullDateTime))
        dataSource.append(dateCellModel)
        
        self.shareableContent[Strings.AddMoney.method] = bankName
        self.shareableContent[Strings.AddMoney.amountAdded] = amountBalance
        self.shareableContent[Strings.AddMoney.newWalletBalance] = walletBalance
        self.shareableContent[Strings.AddMoney.transactionId] = transactionID
        self.shareableContent[Strings.AddMoney.date] = Date().formate(with: .fullDateTime)
        
        return dataSource
    }
}

// MARK: - Setup Cell Actions
extension AddMoneySuccessPresenter {
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.makeDataSource()
            }
        })
    }
}

// MARK: - Controller Actions
extension AddMoneySuccessPresenter {
    func shareButtonAction() {
        var items: [Any] = []

        for (key, value) in self.shareableContent {
            let item = "\(key): \(value)"
            items.append(item)
        }
        
        router?.go(to: .shareSheet(content: items))
    }
    
    func backAction() {
        router?.go(to: .returnBackToHome)
    }
}

// MARK: - AddMoney Success Interactor Output Protocol
extension AddMoneySuccessPresenter: AddMoneySuccessInteractorOutputProtocol {
    
}
