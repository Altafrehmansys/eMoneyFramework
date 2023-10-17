//
//  ManageSavedAccountsPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/05/2023.
//  
//

import Foundation

class ManageSavedAccountsPresenter {

    // MARK: Properties
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    weak var view: ManageSavedAccountsViewProtocol?
    var router: ManageSavedAccountsRouterProtocol?
    var interactor: ManageSavedAccountsInteractorProtocol?
    
    var bankAccountsList: [BankAccountsListResponseModel.PaymentSources] = []
    private var selectedBank: BankAccountsListResponseModel.PaymentSources?
    
    var cardsList: [CardResponseObjectModel.CardResponseObjectDataModel] = []
    private var selectedCard: CardResponseObjectModel.CardResponseObjectDataModel?
    
//    private var filteredBanksList = [BankAccountsListResponseModel.PaymentSources]()
//    private var filteredCardsList = [CardResponseObjectModel.CardResponseObjectDataModel]()
    
    private var isCollapsed = true
    
    var dispatchGroup = DispatchGroup()
}

// MARK: - Class MEthods
extension ManageSavedAccountsPresenter: ManageSavedAccountsPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        
        self.setupCellActions()
        self.makeDataSource()
        
//        self.handleShowMoreAction()
    }
}

// MARK: - Prepare Data Source
extension ManageSavedAccountsPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        
        let addNewBeneficiaryCell = AddNewBeneficiaryCellModel(actions: self.cellActions, title: Strings.AddMoney.addANewMethod, subTitle: Strings.AddMoney.addAnOtherSourceAccountCard, backgroundColor: AppColor.eAnd_Baige.withAlphaComponent(0.2))
        dataSource.append(addNewBeneficiaryCell)
        
        addSavedAccounts()
        addSavedCards()
        
//        let count = bankAccountsList.count + cardsList.count
//        if count > 5 {
//            self.dataSource.append(spaceCell(with: 8))
//
//            let title = isCollapsed ? String(format: Strings.AddMoney.showMore, "\(count - 5)") : Strings.AddMoney.showLess
//            let buttonCell = SingleButtonTableViewCellModel(actions: self.cellActions, title: title, type: .PlainButton, font: AppFont.appMedium(size: .body4))
//            self.dataSource.append(buttonCell)
//        }
        
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
        
        if self.bankAccountsList.isEmpty { return }
        
        var banksDataSource = [StandardCellModel]()
        bankAccountsList.forEach { bank in
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
        
        let titleCell = BankAccountInfoTableViewCellModel(bank: bank)
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
    
    private func addSavedCards() {
        if cardsList.isEmpty { return }
        
        if self.cardsList.isEmpty {
            self.dataSource.append(spaceCell(with: 16))
        }
        
        var dataSource = [StandardCellModel]()
        
        for (_, card) in cardsList.enumerated() {
            let cellModel = LinkedCardsTableViewCellModel(actions: self.cellActions, card: card)
            dataSource.append(cellModel)
            dataSource.append(self.dividerCell())
        }
        
        dataSource.removeLast()
        
        let cellModel = SavedAccountsAndCardsTableViewCellModel(title: Strings.AddMoney.cards, dataSource: dataSource, type: .cards, cornerRadius: 12, borderColor: AppColor.eAnd_Grey_20, borderWidth: 1)
        self.dataSource.append(cellModel)
    }
}

// MARK: - Setup Cell Actions
extension ManageSavedAccountsPresenter {
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { [weak self] (index, model) in
            if let _ = model as? AddNewBeneficiaryCellModel {
                self?.router?.go(to: .addNewBeneficiary)
                return
            }
            
            if let _ = model as? SingleButtonTableViewCellModel {
                self?.isCollapsed.toggle()
                self?.handleShowMoreAction()
                return
            }
            
            if let model = model as? LinkedBanksTableViewCellModel {
                self?.selectedBank = model.bank
                self?.showBankDetailsSheet(with: model.bank)
                return
            }
            
            if let model = model as? LinkedCardsTableViewCellModel {
                self?.selectedCard = model.card
                self?.showCardDetailsSheet(with: model.card)
            }
        })
    }
    
    
    private func handleShowMoreAction() {
//        let totalCount = bankAccountsList.count + cardsList.count
//
//        if totalCount > 5 && isCollapsed {
//            if !cardsList.isEmpty {
//                let numberOfElements = bankAccountsList.isEmpty ? 5 : bankAccountsList.count >= 3 ? 2 : (5 - (bankAccountsList.count))
//                let array = Array(cardsList.prefix(numberOfElements))
//                self.filteredCardsList = array
//            }
//
//            if !bankAccountsList.isEmpty {
//                let numberOfElements = cardsList.isEmpty ? 5 : cardsList.count >= 2 ? 3 : (5 - (cardsList.count))
//                self.filteredBanksList = Array(bankAccountsList.prefix(numberOfElements))
//            }
//        } else {
//            self.filteredBanksList = bankAccountsList
//            self.filteredCardsList = cardsList
//        }
        
        // Making data source
//        self.makeDataSource()
    }
}

// MARK: - Navigations
extension ManageSavedAccountsPresenter {
    
    private func showBankDetailsSheet(with bank: BankAccountsListResponseModel.PaymentSources) {
        var dataSource = [StandardCellModel]()
        
        let titleModel = GenericSingleLabelCellModel(content: Strings.AddMoney.manageMethod, font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, alignment: .center, topSpace: 0, bottomSpace: 20)
        
        let spaceCell = SpaceTableViewCellModel(height: 18)
        dataSource.append(spaceCell)
        
        
        let methodCellModel = MethodOptionTableViewCellModel(image: bank.bankLogoAlt ?? "", name: bank.bankName ?? "", hideArrowImage: true)
        dataSource.append(methodCellModel)
        
        let accontNumbersTitleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.accountNumbers, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, topSpace: 12, bottomSpace: 0)
        dataSource.append(accontNumbersTitleCellModel)
        
        bank.accounts?.forEach({ account in
            let title = NSMutableAttributedString()
            let formattedAccountNumber = formatAccountNumber(account.accountNumber ?? "")

            let accountType = NSAttributedString(string: account.accountName ?? "",
                                                 attributes: [
                                                    NSAttributedString.Key.font: AppFont.appRegular(size: .body3),
                                                    NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80
                                                 ])
            let accountNumber = NSAttributedString(string: formattedAccountNumber,
                                                   attributes: [
                                                    NSAttributedString.Key.font: AppFont.appSemiBold(size: .body3),
                                                    NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80
                                                   ])
            title.append(accountType)
            title.append(NSAttributedString(string: " "))
            title.append(accountNumber)
            
            let accontCellModel = GenericSingleLabelCellModel(content: "", attributedContent: title, topSpace: 1, bottomSpace: 1)
            dataSource.append(accontCellModel)
        })
        
        let accontStatusTitleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.accountStatus, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, topSpace: 12, bottomSpace: 0)
        dataSource.append(accontStatusTitleCellModel)
        
        let accontStatusCellModel = GenericSingleLabelCellModel(content: bank.paymentSourceStatus ?? "", font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Black_80, topSpace: 0, bottomSpace: 20)
        dataSource.append(accontStatusCellModel)
        
        let tableViewCell = TableViewCellModelWithUITableView(dataSource: dataSource, borderWidth: 1, borderColor: AppColor.eAnd_Baige, cornerRadius: 20, leftSpace: 24, rightSpace: 24, topSpace: 10)
        
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .PlainButton
        removeMethodButton.setTitle(Strings.AddMoney.removeThisMethod, for: .normal)
        
        removeMethodButton.addTarget(self, action: #selector(removeBankButtonTappedAction), for: .touchUpInside)
        
        router?.go(to: .manageBankAccount(dataSource: [titleModel, tableViewCell], actions: [removeMethodButton]))
    }
    
    func formatAccountNumber(_ accountNumber: String) -> String {
        let chunkSize = 4
        let numberOfChunks = (accountNumber.count + chunkSize - 1) / chunkSize
        var formattedAccountNumber = ""

        for chunkIndex in 0..<numberOfChunks {
            let startIndex = accountNumber.index(accountNumber.startIndex, offsetBy: chunkIndex * chunkSize)
            let endIndex = accountNumber.index(startIndex, offsetBy: min(chunkSize, accountNumber.count - chunkIndex * chunkSize))
            let chunk = accountNumber[startIndex..<endIndex]

            formattedAccountNumber += String(chunk)

            if chunkIndex != numberOfChunks - 1 {
                formattedAccountNumber += " "
            }
        }

        return formattedAccountNumber
    }
}

// MARK: - Navigations
extension ManageSavedAccountsPresenter {
    
    private func showCardDetailsSheet(with card: CardResponseObjectModel.CardResponseObjectDataModel) {
        var dataSource = [StandardCellModel]()
        
        let titleModel = GenericSingleLabelCellModel(content: Strings.AddMoney.manageMethod, font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, alignment: .center, topSpace: 0, bottomSpace: 20)
        
        let spaceCell = SpaceTableViewCellModel(height: 18)
        dataSource.append(spaceCell)
        
        let methodCellModel = MethodOptionTableViewCellModel(image: card.imageUrl ?? "", name: card.brand ?? "", hideArrowImage: true)
        dataSource.append(methodCellModel)
        
        let cardNumberTitleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.cardNumber, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, topSpace: 12, bottomSpace: 0)
        dataSource.append(cardNumberTitleCellModel)
        
        let cardNumberModel = GenericSingleLabelCellModel(content: (card.maskedCardNumber ?? ""), font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, topSpace: 0, bottomSpace: 20)
        dataSource.append(cardNumberModel)
        
        let tableViewCell = TableViewCellModelWithUITableView(dataSource: dataSource, borderWidth: 1, borderColor: AppColor.eAnd_Baige, cornerRadius: 20, leftSpace: 24, rightSpace: 24, topSpace: 10)
        
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .PlainButton
        removeMethodButton.setTitle(Strings.AddMoney.removeThisMethod, for: .normal)
        
        removeMethodButton.addTarget(self, action: #selector(removeCardButtonTappedAction), for: .touchUpInside)
        
        router?.go(to: .manageBankAccount(dataSource: [titleModel, tableViewCell], actions: [removeMethodButton]))
    }
}

// MARK: - Actions
extension ManageSavedAccountsPresenter {
    
    @objc private func removeBankButtonTappedAction() {
        
        var dataSource = [StandardCellModel]()
        
        let titleCellModel = TitleImageTableViewCellModel(titleImage: "trash_icon", title: Strings.AddMoney.areYouSureToRemove, titleFont: AppFont.appSemiBold(size: .h7), titleColor: AppColor.eAnd_Black_80)
        dataSource.append(titleCellModel)
        
        let bankName = self.selectedBank?.bankName ?? ""
        let content = String(format: Strings.AddMoney.removeCardDesc, bankName)
        let descModel = GenericSingleLabelCellModel(content: content, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, alignment: .center)
        dataSource.append(descModel)
        
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .GradientButton
        removeMethodButton.setTitle(Strings.AddMoney.removeThisMethod, for: .normal)
        removeMethodButton.addTarget(self, action: #selector(removeBankAction), for: .touchUpInside)
        
        let cancelButton = BaseButton()
        cancelButton.type = .PlainButton
        cancelButton.setTitle(Strings.Generic.cancel, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        router?.go(to: .remove(dataSource: dataSource, actions: [removeMethodButton, cancelButton]))
    }
    
    @objc private func removeCardButtonTappedAction() {
        
        var dataSource = [StandardCellModel]()
        
        let titleCellModel = TitleImageTableViewCellModel(titleImage: "trash_icon", title: Strings.AddMoney.areYouSureToRemove, titleFont: AppFont.appSemiBold(size: .h7), titleColor: AppColor.eAnd_Black_80)
        dataSource.append(titleCellModel)
        
        let descModel = GenericSingleLabelCellModel(content: Strings.AddMoney.removeCardDescriptionString, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, alignment: .center)
        dataSource.append(descModel)
        
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .GradientButton
        removeMethodButton.setTitle(Strings.AddMoney.removeThisMethod, for: .normal)
        removeMethodButton.addTarget(self, action: #selector(removeCardAction), for: .touchUpInside)
        
        let cancelButton = BaseButton()
        cancelButton.type = .PlainButton
        cancelButton.setTitle(Strings.Generic.cancel, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        router?.go(to: .remove(dataSource: dataSource, actions: [removeMethodButton, cancelButton]))
    }
    
    @objc private func removeBankAction() {
        if let sourceId = self.selectedBank?.paymentSourceId {
            router?.go(to: .cancelButtonAction)
            Loader.shared.showFullScreen()
            interactor?.removeBankAccount(with: sourceId)
        }
    }
    
    @objc private func removeCardAction() {
        if let selectedCard {
            router?.go(to: .cancelButtonAction)
            Loader.shared.showFullScreen()
            interactor?.removeDebitCard(with: selectedCard)
        }
    }
    
    @objc private func cancelAction() {
        router?.go(to: .cancelButtonAction)
    }
}

// MARK: - Outputs
extension ManageSavedAccountsPresenter: ManageSavedAccountsInteractorOutputProtocol {
    
    func onRemoveBankAccount(Response response: BankAccountsListResponseModel?) {
        Loader.shared.hideFullScreen()
        view?.showRemovedMethodNotificationView(isCard: false)
        if let paymentsSources = response?.data?.paymentSources {
            self.bankAccountsList = paymentsSources
        } else {
            self.bankAccountsList = []
        }
        
        self.router?.go(to: .updateRootVC)
        self.makeDataSource()
    }
    
    func onRemoveBankAccount(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
    
    func onDebitCardRemove(Response response: InitializeCardPaymentResponseModel) {
        Loader.shared.hideFullScreen()
        self.view?.showRemovedMethodNotificationView(isCard: true)
        self.cardsList.removeAll(where: {$0.cardNumber == self.selectedCard?.cardNumber})
        self.router?.go(to: .updateRootVC)
        self.makeDataSource()
    }
    
    func onDebitCardRemove(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
}
