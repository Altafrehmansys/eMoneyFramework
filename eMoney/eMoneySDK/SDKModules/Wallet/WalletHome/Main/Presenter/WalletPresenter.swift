//
//  WalletPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation

class WalletPresenter {
    
    // MARK: Properties
    
    weak var view: WalletViewProtocol?
    var router: WalletRouterProtocol?
    var interactor: WalletInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    private var banksData: [WalletBankData] = []
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case card
            case bank
            case addNewMethod
            case savedCard
            case general
        }
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
    
}

extension WalletPresenter: WalletPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.eAndMoneyAccountsDataSource()
        interactor?.getBankAccounts()
    }
    
    func eAndMoneyAccountsDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.seteAndMoneyDataSource()
        view?.reloadData()
    }
    func savedAccountsDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.setSavedAccountsDataSource()
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
    
    private func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
            if let model = model as? SavedAccountCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .bank:
                    self.loadBankBottomSheetView()
                case .card:
                    self.loadCardBottomSheetView()
                default:
                    break
                }
            }
            
            if let model = model as? AddNewMethodCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .addNewMethod:
                   print("add mew method cell tapped")
                default:
                    break
                }
            }
            
            if let model = model as? EAndMoneyAccountsCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .card:
                    self.navigateToCardDetails()
                default:
                    break
                }
            }
            
            
        }
    }
    
    private func seteAndMoneyDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(SingleLabelCellModel(title:Strings.Wallet.your_cards))
        dataSource.append(EAndMoneyAccountsCellModel(actions: self.cellActions,cardImage: "red_card", accountType: "e& money account", name: "Abdullah Mohammed", cardNumber: "1234 **** **** 3456", accountBalance: "Balance AED 740.00",methodType:MethodType(type:.card)))
        dataSource.append(spaceCell(with: 8))
        dataSource.append(AddNewCardCellModel(addNewCardTitle:Strings.Wallet.add_new_card))
        
        //  dataSource.append(EAndMoneyBankAccountCellModel(cardImage: "red_card", accountType: "e& money account", name: "Abdullah Mohammed", accountBalance: "Balance AED 740.00"))
        return dataSource
    }
    
    private func setSavedAccountsDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(SingleLabelCellModel(title:"Banks",titleFont: AppFont.appRegular(size: .body4),titleColor: AppColor.eAnd_Black_80))
        
        for bank in banksData {
            dataSource.append(TableViewCellModelWithUITableView(dataSource: self.getBanksDataSource(bankName: bank.bankName ?? "", accounts: bank.accounts),
                                                                        borderWidth: 1,
                                                                        borderColor: AppColor.eAnd_Grey_30,
                                                                        cornerRadius: 10,
                                                                        leftSpace: 24,
                                                                        rightSpace: 24))
        }
//        dataSource.append(TableViewCellModelWithUITableView(dataSource: self.getBanksDataSource(),
//                                                            borderWidth: 1,
//                                                            borderColor: AppColor.eAnd_Grey_30,
//                                                            cornerRadius: 10,
//                                                            leftSpace: 24,
//                                                            rightSpace: 24))
        dataSource.append(SpaceTableViewCellModel(height: 20))
        dataSource.append(TableViewCellModelWithUITableView(dataSource: self.get2BanksDataSource(),
                                                            borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 10,
                                                            leftSpace: 24,
                                                            rightSpace: 24))
        
        dataSource.append(SingleLabelCellModel(title:"Card",titleFont: AppFont.appRegular(size: .body4),titleColor: AppColor.eAnd_Black_80))
        dataSource.append(TableViewCellModelWithUITableView(dataSource: self.getCardsDataSource(),
                                                            borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 10,
                                                            leftSpace: 24,
                                                            rightSpace: 24))
        dataSource.append(SpaceTableViewCellModel(height: 20))
        
        dataSource.append(SingleLabelCellModel(title:"Add new method",titleFont: AppFont.appSemiBold(size: .body2),titleColor: AppColor.eAnd_Black_80))
        dataSource.append(AddNewMethodCellModel(actions: self.cellActions,image:"etisalat", title: "Bank account",methodType: MethodType(type: .addNewMethod)))
        dataSource.append(dividerCell())
        dataSource.append(AddNewMethodCellModel(actions: self.cellActions,image:"etisalat", title: "Debit / credit card",methodType: MethodType(type: .addNewMethod)))
        
        return dataSource
    }
    
    private func get2BanksDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(SingleLabelCellModel(title:"Emirates Islamic Bank",titleFont: AppFont.appSemiBold(size: .body3),titleColor: AppColor.eAnd_Black_80))
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "etisalat", account: "Special current account", cardNumber: "*** 1528",methodType: MethodType(type:.bank)))
        return dataSource
    }
    
    private func getBanksDataSource(bankName: String, accounts: [WalletBankAccount]) -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(SingleLabelCellModel(title: bankName,titleFont: AppFont.appSemiBold(size: .body3),titleColor: AppColor.eAnd_Black_80))
        dataSource.append(SavedAccountCellModel(cardImage: "etisalat", account: "Special current account", cardNumber: "*** 1528"))

        dataSource.append(dividerCell())
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "etisalat", account: "Special current account", cardNumber: "*** 1528",methodType:MethodType(type:.bank)))
        return dataSource
    }
    
    private func getCardsDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "etisalat", account: "Special current account", cardNumber: "*** 1528",methodType:MethodType(type:.card)))
        dataSource.append(dividerCell())
        dataSource.append(SavedAccountCellModel(actions: self.cellActions,cardImage: "etisalat", account: "Special current account", cardNumber: "*** 1528",methodType:MethodType(type:.card)))
        return dataSource
    }
}

extension WalletPresenter{
    
    func loadBankBottomSheetView() {
        var dataSource = [StandardCellModel]()
        
        let titleModel = GenericSingleLabelCellModel(content:"Manage account", font: AppFont.appRegular(size: .body2), color: AppColor.eAnd_Black_80, alignment: .center, topSpace: 0, bottomSpace: 20)
        
        let spaceCell = SpaceTableViewCellModel(height: 18)
        dataSource.append(spaceCell)
        
        let methodCellModel = MethodOptionTableViewCellModel(image:"etisalat", name: "Emirates NBD", hideArrowImage: true)
        dataSource.append(methodCellModel)
    
        dataSource.append(GenericSingleLabelCellModel(content:"Account holder name", font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, topSpace: 12))
        dataSource.append(GenericSingleLabelCellModel(content:"Javed Ansari", font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Black_80))
        
            let title = NSMutableAttributedString()
            let formattedAccountNumber = formatAccountNumber("8127 8126 9476 1511")

            let accountType = NSAttributedString(string:"Current account",
                                                 attributes: [
                                                    NSAttributedString.Key.font: AppFont.appRegular(size: .body3),
                                                    NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80
                                                 ])
        let accountNumber = NSAttributedString(string: formattedAccountNumber ,
                                                   attributes: [
                                                    NSAttributedString.Key.font: AppFont.appSemiBold(size: .body3),
                                                    NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80
                                                   ])
            title.append(accountType)
            title.append(NSAttributedString(string: ""))
            title.append(accountNumber)
        
            let accontCellModel = GenericSingleLabelCellModel(content: "", attributedContent: title, topSpace: 0, bottomSpace: 0)
            dataSource.append(accontCellModel)
        
        let accontStatusTitleCellModel = GenericSingleLabelCellModel(content: Strings.AddMoney.accountStatus, font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_100, topSpace: 12, bottomSpace: 0)
        dataSource.append(accontStatusTitleCellModel)
        
        let accontStatusCellModel = GenericSingleLabelCellModel(content:"", font: AppFont.appRegular(size: .body3), color: AppColor.eAnd_Black_80, topSpace: 0, bottomSpace: 20)
        dataSource.append(accontStatusCellModel)
        
        let tableViewCell = TableViewCellModelWithUITableView(dataSource: dataSource, borderWidth: 1, borderColor: AppColor.eAnd_Baige, cornerRadius: 20, leftSpace: 24, rightSpace: 24, topSpace: 10)
        
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .PlainButton
        removeMethodButton.setTitle(Strings.AddMoney.removeThisMethod, for: .normal)
        
        removeMethodButton.addTarget(self, action: #selector(removeBankButtonTappedAction), for: .touchUpInside)
        
        self.router?.go(to: .loadBankBottomSheetView(dataSource: [titleModel, tableViewCell], actions: [removeMethodButton]))
    }
    
    @objc private func removeBankButtonTappedAction() {

        var dataSource = [StandardCellModel]()
        
        let titleCellModel = TitleImageTableViewCellModel(titleImage: "trash_icon", title: Strings.AddMoney.areYouSureToRemove, titleFont: AppFont.appSemiBold(size: .h7), titleColor: AppColor.eAnd_Black_80)
        dataSource.append(titleCellModel)

        dataSource.append(GenericSingleLabelCellModel(content: "Removing would lead to delinking of all Emirates NBD accounts from your e& money wallet.", font: AppFont.appRegular(size: .body4), color: AppColor.eAnd_Grey_70, alignment: .center))
        
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
    
    @objc private func removeBankAction() {
    }
    @objc private func cancelAction() {
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
    
    
    func loadCardBottomSheetView() {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(GenericSingleLabelCellModel(content: "Manage card",font: AppFont.appRegular(size: .body2),color: AppColor.eAnd_Black_80,alignment:.center))
        dataSource.append(CardDetailsTableViewCellModel(holderName: "Mohammed Ahmed", cardNumber: "5477 0412 3456 7890", expiryDate: "02/24", cvv: "180"))
        let updateCardButton = BaseButton()
        updateCardButton.type = .GradientButton
        updateCardButton.setTitle("Update card details", for: .normal)
        updateCardButton.addTarget(self, action: #selector(updateCardButtonTapped), for: .touchUpInside)
        let removeMethodButton = BaseButton()
        removeMethodButton.type = .PlainButton
        removeMethodButton.setTitle("Remove this method", for: .normal)
        removeMethodButton.addTarget(self, action: #selector(removeMethodButtonTapped), for: .touchUpInside)
        self.router?.go(to: .loadCardBottomSheetView(dataSource: dataSource,actions: [updateCardButton,removeMethodButton]))
        
    }
    
    @objc private func updateCardButtonTapped() {

    
    }
    @objc private func removeMethodButtonTapped() {

    
    }
    
    func navigateToCardDetails() {
        self.router?.go(to: .navigateToCardDetail)
    }
}

extension WalletPresenter: WalletInteractorOutputProtocol {
    
}
