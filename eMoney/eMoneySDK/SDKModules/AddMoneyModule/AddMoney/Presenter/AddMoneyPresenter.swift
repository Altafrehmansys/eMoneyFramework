//
//  AddMoneyPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation
import PassKit

class AddMoneyPresenter {
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    // MARK: Properties
    weak var view: AddMoneyViewProtocol?
    var router: AddMoneyRouterProtocol?
    var interactor: AddMoneyInteractorProtocol?
    
    var isComingFromManagedSavedAccounts = false
    var leanCustomerID: String = ""
    var leanPaymentDestinationID: String = ""
    
    private var bankAccountsList: [BankAccountsListResponseModel.PaymentSources] = []
    private var cardsList: [CardResponseObjectModel.CardResponseObjectDataModel] = []
    
    private var filteredBanksList = [BankAccountsListResponseModel.PaymentSources]()
    private var filteredCardsList = [CardResponseObjectModel.CardResponseObjectDataModel]()
    
    private var isCollapsed = true
    private var isInitialLoading = true
    private var leanCoolOffRemainingTime: Int = 0
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType: String {
            case bankAcount = "BANK_ACCOUNT"
            case creditDebitCard = "DEBIT_CREDIT_CARD"
            case applePay = "APPLE_PAY"
            case cashAdvance = "CASH_ADVANCE"
            case paymentMachines = "PAYMENT_MACHINES"
            case agents = "AGENTS"
            case general = "GENERAL"
        }
        
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
    
    enum ScreenOpeningStates {
        case normal
        case managedSavedAccount
    }
    var openState: ScreenOpeningStates = .normal
    
    var dispatchGroup = DispatchGroup()
    
    // MARK: Apple pay Parameters
    var payment: PKPaymentRequest = {
      let request = PKPaymentRequest()
      request.merchantIdentifier = "merchant.ae.comtrust.ipg"
      request.supportedNetworks = [.masterCard,.visa,.amex]
      request.supportedCountries = ["US"]
      request.merchantCapabilities = .capability3DS
      if #available(iOS 15.0, *) {
        request.couponCode = "AED"
      } else {
        // Fallback on earlier versions
      }
      request.currencyCode = "AED"
      request.countryCode = "US"
      
      return request
      
    }()
}

extension AddMoneyPresenter: AddMoneyPresenterProtocol {
    func loadData() {
        view?.setupUI()
        
        self.makeAPICalls()
        self.setupCellActions()
    }
}

// MARK: - Make Data Source
extension AddMoneyPresenter {
    func makeDataSource() {
        self.dataSource.removeAll()
        
        if self.filteredBanksList.isEmpty == false || self.filteredCardsList.isEmpty == false {
            let titleCellModel = GenericTitleAndButtonTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.savedAccounts, buttonTitle: Strings.AddMoney.manage)
            self.dataSource.append(titleCellModel)
        }
        
        addSavedAccounts()
        addSavedCards()
        
        let count = bankAccountsList.count + cardsList.count
        if count > 5 {
            self.dataSource.append(spaceCell(with: 8))
            
            let title = isCollapsed ? String(format: Strings.AddMoney.showMore, "\(count - 5)") : Strings.AddMoney.showLess
            let buttonCell = SingleButtonTableViewCellModel(actions: self.cellActions, title: title, type: .PlainButton, font: AppFont.appMedium(size: .body4))
            self.dataSource.append(buttonCell)
        }

        addPaymentOptions()

        view?.reloadData()
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func addSavedAccounts() {
        
        if self.filteredBanksList.isEmpty { return }
        
        var banksDataSource = [StandardCellModel]()
        filteredBanksList.forEach { bank in
            banksDataSource.append(self.getBankDetailsCell(with: bank))
            banksDataSource.append(self.spaceCell(with: 16))
        }
        banksDataSource.removeLast()
        
        let cellModel = SavedAccountsAndCardsTableViewCellModel(title: Strings.AddMoney.banks, dataSource: banksDataSource, type: .banks)
        self.dataSource.append(cellModel)
        self.dataSource.append(spaceCell(with: 26))
    }
    
    // MARK: - Configure Cell with bank details
    private func getBankDetailsCell(with bank: BankAccountsListResponseModel.PaymentSources) -> StandardCellModel {
        var dataSource = [StandardCellModel]()
        
        let titleCell = BankAccountInfoTableViewCellModel(actions: self.cellActions, bank: bank)
        dataSource.append(titleCell)
        
        bank.accounts?.forEach { account in
            let model = LinkedBanksTableViewCellModel(actions: self.cellActions, bank: bank, account: account)
            dataSource.append(model)
            dataSource.append(self.dividerCell())
        }
        dataSource.removeLast()
        
        let tableViewCellModel = TableViewCellModelWithUITableView(dataSource: dataSource, borderWidth: 1, borderColor: AppColor.eAnd_Grey_20, cornerRadius: 12)
        return tableViewCellModel
    }
    
    // MARK: - Add Payment options
    private func addPaymentOptions() {
        
        if let optionsList = GlobalData.shared.addMoneyMetaDataResponse?.data?.appResourceResponses {
            optionsList.forEach { [weak self] (model) in
                guard let `self` = self else { return }
                let titleCell = GenericSingleLabelCellModel(content: model.title ?? "", font: AppFont.appSemiBold(size: .body2), topSpace: 0)
                self.dataSource.append(titleCell)
                
                if let subResources = model.subResources {
                    for (_, innerModel) in subResources.enumerated() {
                        let methodType = MethodType(type: MethodType.CellType(rawValue: innerModel.identifier) ?? .general)
                        
                        let methodCell2 = MethodOptionTableViewCellModel(actions: self.cellActions, image: innerModel.iconImageUrl, name: innerModel.title, subtitle: innerModel.description, methodType: methodType)
                        self.dataSource.append(methodCell2)
                        self.dataSource.append(self.dividerCell())
                    }
                }
                
                self.dataSource.removeLast()
                self.dataSource.append(spaceCell(with: 8))
            }
        }
    }
    
    private func addSavedCards() {
        if filteredCardsList.isEmpty { return }
        
        if self.filteredBanksList.isEmpty {
            self.dataSource.append(spaceCell(with: 8))
        }
        
        var dataSource = [StandardCellModel]()
        self.filteredCardsList.forEach { [unowned self] card in
            let cellModel = LinkedCardsTableViewCellModel(actions: self.cellActions, card: card)
            dataSource.append(cellModel)
            dataSource.append(self.dividerCell())
        }
        
        dataSource.removeLast()
        
        let cellModel = SavedAccountsAndCardsTableViewCellModel(title: Strings.AddMoney.cards, dataSource: dataSource, type: .cards, cornerRadius: 12, borderColor: AppColor.eAnd_Grey_20, borderWidth: 1)
        self.dataSource.append(cellModel)
        self.dataSource.append(spaceCell(with: 8))
    }
}

// MARK: - Handle Actions
extension AddMoneyPresenter {
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            
            if let _ = model as? GenericTitleAndButtonTableViewCellModel {
                let input = ManageSavedAccountsRouter.Input(bankAccountsList: self.bankAccountsList, cardsList: self.cardsList)
                self.router?.go(to: .manageSavedAccounts(input: input))
                return
            }
            
            if let _ = model as? SingleButtonTableViewCellModel {
                self.isCollapsed.toggle()
                self.handleShowMoreAction()
                return
            }
            
            if let model = model as? BankAccountInfoTableViewCellModel {
                if index == 0 {
                    self.leanCoolOffRemainingTime = model.remainingTimer
                } else {
                    if let bankIndex = self.bankAccountsList.firstIndex(where: {$0.bankIdentifier == model.bank.bankIdentifier}) {
                        self.bankAccountsList[bankIndex] = model.bank
                        self.makeDataSource()
                    }
                }
            }
            
            if let model = model as? LinkedCardsTableViewCellModel {
                let title = Strings.AddMoney.via + " " + (model.card.brand ?? "")
                let input = AddMoneyEnterAmountRouter.input(title: title,
                                                            subtitle: (model.card.maskedCardNumber ?? ""),
                                                            logo: model.card.imageUrl ?? "",
                                                            currentFlow: .debitCard,
                                                            selectedDebitCard: model.card)
                self.router?.go(to: .payWithCard(input: input))
            }
            
            if let model = model as? LinkedBanksTableViewCellModel {
                if let status = model.bank.paymentSourceStatus, status == "AWAITING_BENEFICIARY_COOL_OFF" {
                    self.router?.go(to: .leanCoolOffBottomSheet(interval: self.leanCoolOffRemainingTime))
                } else {
                    let title = Strings.AddMoney.via + " " + (model.bank.bankName ?? "")
                    let subtitle = (model.account.accountName ?? "") + " " + (model.account.maskedAccountNumber ?? "")
                    let input = AddMoneyEnterAmountRouter.input(title: title,
                                                                subtitle: subtitle,
                                                                logo: model.bank.bankLogoAlt ?? "",
                                                                currentFlow: .lean,
                                                                selectedLeanBank: model.bank,
                                                                selectedAccountId: model.account.accountId)
                    self.router?.go(to: .showLeanAccount(input: input))
                }
            }
            
            if let model = model as? MethodOptionTableViewCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .bankAcount:
                    self.router?.go(to: .selectBank(linkedAccountsList: self.bankAccountsList))
                case .creditDebitCard:
                    self.initializeAddDebitCard()
                case .applePay:
                    let title = Strings.AddMoney.via + " " + model.name
                    let input = AddMoneyEnterAmountRouter.input(title: title, subtitle: "", logo: model.image, currentFlow: .applePay)
                    self.router?.go(to: .applePay(input: input))
                case .paymentMachines:
                    self.router?.go(to: .paymentMachine(getLocationNearByType: GetLocationsView.paymentMachinesView.rawValue))
                case .agents:
                    self.router?.go(to: .paymentMachine(getLocationNearByType: GetLocationsView.agentsView.rawValue))
                case .cashAdvance:
                    let title = Strings.AddMoney.via + " " + model.name
                    let input = AddMoneyEnterAmountRouter.input(title: title, subtitle: model.subtitle ?? "", logo: model.image, currentFlow: .cashAdvance)
                    self.router?.go(to: .cashAdvance(input: input))
                default:
                    break
                }
            }
        })
    }
    
    private func handleShowMoreAction() {
        let totalCount = bankAccountsList.count + cardsList.count
        
        if totalCount > 5 && isCollapsed {
            if !cardsList.isEmpty {
                let numberOfElements = bankAccountsList.isEmpty ? 5 : bankAccountsList.count >= 3 ? 2 : (5 - (bankAccountsList.count))
                let array = Array(cardsList.prefix(numberOfElements))
                self.filteredCardsList = array
            }
            
            if !bankAccountsList.isEmpty {
                let numberOfElements = cardsList.isEmpty ? 5 : cardsList.count >= 2 ? 3 : (5 - (cardsList.count))
                self.filteredBanksList = Array(bankAccountsList.prefix(numberOfElements))
            }
        } else {
            self.filteredBanksList = bankAccountsList
            self.filteredCardsList = cardsList
        }
        
        // Making data source
        self.makeDataSource()
    }
}


// MARK: - Handle Navigations
extension AddMoneyPresenter {
    func dismissView() {
        self.router?.go(to: .back(withAnimation: true))
    }
}

// MARK: - API Calls
extension AddMoneyPresenter {
    
    private func makeAPICalls() {
        if let view = view as? AddMoneyViewController, isInitialLoading {
            isInitialLoading = false
            Loader.shared.showWithoutGreyBackground(in: view.mainContainerView)
        }
        
        if openState != .managedSavedAccount {
            self.getBankAccountsList()
            self.getCardsList()
        }
        self.getOptionsList()
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            if let view = self.view as? AddMoneyViewController {
                Loader.shared.hide(view: view.mainContainerView)
            }
            
            // Prepare arrays for show more/less functionality
            self.handleShowMoreAction()
        }
    }
    
    private func getOptionsList() {
        
        if let _ = GlobalData.shared.addMoneyMetaDataResponse {
            return
        }
        
        dispatchGroup.enter()
        interactor?.getAddMoneyMetaData()
    }
    
    private func getBankAccountsList() {
        dispatchGroup.enter()
        interactor?.getBankAccountsList()
    }
    
    private func getCardsList() {
        dispatchGroup.enter()
        interactor?.getCardsListRequest()
    }
    
    private func initializeAddDebitCard() {
        Loader.shared.showFullScreen()
        interactor?.initializeAddCard()
    }
}

// MARK: - Responses
extension AddMoneyPresenter: AddMoneyInteractorOutputProtocol {
    func onMetaData(Response response: AddMoneyMetaDataResponseModel?) {
        GlobalData.shared.addMoneyMetaDataResponse = response
        dispatchGroup.leave()
    }
    
    func onMetaData(Error error: AppError) {
        dispatchGroup.leave()
        Alert.showBottomSheetError(index: 101, title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
    
    func onBankAccountsList(Response response: BankAccountsListResponseModel?) {
        if let paymentsSources = response?.data?.paymentSources {
            self.bankAccountsList = paymentsSources
        } else {
            self.bankAccountsList = []
        }
        dispatchGroup.leave()
    }
    
    func onBankAccountsList(Error error: AppError) {
        dispatchGroup.leave()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
    
    func onCardsList(Response response: CardResponseObjectModel) {
        if var cards = response.data {
            cards.removeAll(where: {$0.brand?.lowercased() == "apple"})
            self.cardsList = cards
        }
        dispatchGroup.leave()
    }
    
    func onCardsList(Error error: AppError) {
        dispatchGroup.leave()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
    
    func onAddCard(Response response: AddDebitCardResponseModel) {
        Loader.shared.hideFullScreen()
        if let data = response.data, let url = data.url, let _ = data.transactionId {
            if let url = URL(string: url) {
                var request = URLRequest(url: url)
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET"
                
                let input = AddMoneyWebViewRouter.Input(request: request, currentFlow: .initializeDebitCard)
                router?.go(to: .loadWebViewWith(input: input))
            }
        }
    }
    
    func onAddCard(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription, actionBtnTitle: Strings.Generic.ok, delegate: self)
    }
}

// MARK: - Error Sheet Delegate Methods
extension AddMoneyPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        if index == 101 {
            self.router?.go(to: .back(withAnimation: false))
        }
    }
    
    func closeBtnTapped() {
//        self.router?.go(to: .back(withAnimation: false))
    }
}
