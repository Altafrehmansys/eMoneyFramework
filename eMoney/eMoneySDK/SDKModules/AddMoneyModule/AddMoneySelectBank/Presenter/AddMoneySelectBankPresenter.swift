//
//  AddMoneySelectBankPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 25/04/2023.
//  
//

import Foundation
import LeanSDK

class AddMoneySelectBankPresenter {

    // MARK: Properties
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    weak var view: AddMoneySelectBankViewProtocol?
    var router: AddMoneySelectBankRouterProtocol?
    var interactor: AddMoneySelectBankInteractorProtocol?
    
    private var banksList: [AddMoneyMetaDataResponseModel.BankDataModel]?
    private var popularBanks: [AddMoneyMetaDataResponseModel.BankDataModel]?
    private var filteredBanksList: [AddMoneyMetaDataResponseModel.BankDataModel]?
    
    var linkedAccountsList: [BankAccountsListResponseModel.PaymentSources]?
    var type: MethodType.CellType = .general
    
    public var selectedBank: AddMoneyMetaDataResponseModel.BankDataModel?
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType: String {
            case epg = "EPG"
            case lean = "LEAN"
            case general = "GENERAL"
        }
        
        var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
        }
    }
}

extension AddMoneySelectBankPresenter: AddMoneySelectBankPresenterProtocol {
    func loadData() {
        self.setupCellActions()
        self.view?.setupUI()
        self.prepareDataForDataSource()
        
        guard let _ = self.linkedAccountsList else {
            Loader.shared.showFullScreen()
            self.interactor?.getBankAccountsList()
            return
        }
    }
}

// MARK: - Prepare Data source
extension AddMoneySelectBankPresenter {
    
    private func prepareDataForDataSource() {
        
        self.popularBanks = getPopularBanks
        self.banksList = getBanksList
        self.filteredBanksList = getBanksList
        self.makeDataSource()
    }
    
    func makeDataSource() {
        self.dataSource.removeAll()
        
        self.addPopularBanks()
        self.dataSource.append(self.spaceCell(with: 20))
        
        let allBanksTitleCell = GenericTitleAndButtonTableViewCellModel(actions: cellActions, title: Strings.AddMoney.allBanks, buttonTitle: Strings.AddMoney.cantFindYourBank)
        self.dataSource.append(allBanksTitleCell)
        
        let searchField = SearchFieldTableViewCellModel(actions: cellActions)
        self.dataSource.append(searchField)
        
        self.addBanksList()
        
        view?.reloadData()
    }
    
    private func addPopularBanks() {
        
        guard let popularBanks = self.popularBanks else { return }
        var popularBanksDataSource = [StandardCellModel]()
        
        popularBanks.forEach({popularBanksDataSource.append(PopularBanksCollectionViewCellModel(actions: self.cellActions, bank: $0))})
        let banksCellModel = PopularBanksTableViewCellModel(actions: self.cellActions, title: Strings.AddMoney.popularBanks, dataSource: popularBanksDataSource)
        dataSource.append(banksCellModel)
    }
    
    private func addBanksList() {
        let cellModel = TableViewCellModelWithUITableView(actions: self.cellActions, dataSource: self.banksListDataSource)
        self.dataSource.append(cellModel)
    }
    
    private func connectBankAccount() {
        LeanSDKManager.shared.setupLeanSDK()
        LeanSDKManager.shared.delegate = self
        
        let leanCustomer = GlobalData.shared.addMoneyMetaDataResponse?.data?.leanCustomerData
        router?.openConnectAccountSDK(customerID: leanCustomer?.customerID ?? "", bankID: self.selectedBank?.bankIdentifier ?? "" , paymentDestinationID: leanCustomer?.destinationID ?? "")
    }
    
    private func updateBanksList(with searchText: String) {
        
        let searchedText = searchText.removeLeadingAndTrailingSpaces()
        if searchedText.isEmpty || searchText.count < 3 {
            self.filteredBanksList = self.banksList
        } else {
            self.filteredBanksList = self.banksList?.filter({ listModel in
                if let name = listModel.bankName?.lowercased(), name.contains(searchedText.lowercased()) {
                    return true
                }
                return false
            })
        }
        
        (self.dataSource.first(where: {$0 is TableViewCellModelWithUITableView}) as? TableViewCellModelWithUITableView)?.dataSource = self.banksListDataSource
        self.view?.updateBanksList()
    }
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
}

// MARK: - Setup Cells Actions
extension AddMoneySelectBankPresenter {
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { [weak self] (index, model) in
            guard let `self` = self else { return }
            
            if let model = model as? PopularBanksCollectionViewCellModel {
                if let bankType = model.bank.type {
                    let type = MethodType(type: MethodType.CellType(rawValue: bankType) ?? .general)
                    switch type.type {
                    case MethodType.CellType.lean:
                        self.selectedBank = model.bank
                        self.openAccountLinkingFlow()
                        
                    case MethodType.CellType.epg:
                        self.router?.go(to: .enterAmount(image: model.bank.bankLogoAlt ?? "", name: model.bank.bankName ?? ""))
                        
                    default:
                        break
                    }
                }
                return
            }
            
            if let model = model as? SearchFieldTableViewCellModel {
                self.updateBanksList(with: model.searchText)
            }
            
            if let _ = model as? GenericTitleAndButtonTableViewCellModel {
                self.router?.go(to: .cantFindYourBank)
                return
            }
 
            if let model = model as? MethodOptionTableViewCellModel, let methodType = model.methodType as? MethodType {
                if methodType.type == .lean {
                    self.selectedBank = self.filteredBanksList?.first(where: {$0.bankIdentifier == model.paymentSourceId})
                    self.openAccountLinkingFlow()
                } else {
                    self.router?.go(to: .enterAmount(image: model.image, name: model.name))
                }
            }
        })
    }
}

// MARK: - Computed Properties
extension AddMoneySelectBankPresenter {
    private var banksListDataSource: [StandardCellModel] {
        get {
            var dataSource = [StandardCellModel]()
            if let filteredBanksList, !filteredBanksList.isEmpty {
                filteredBanksList.forEach { model in
                    let methodCell1 = MethodOptionTableViewCellModel(actions: cellActions, image: model.bankLogoAlt ?? "", name: model.bankName ?? "", methodType: MethodType(type: MethodType.CellType(rawValue: model.type ?? "") ?? .general), paymentSourceId: model.bankIdentifier)
                    dataSource.append(methodCell1)
                    dataSource.append(self.dividerCell())
                }
                if dataSource.count > 2 {
                    dataSource.removeLast()
                }
            } else {
                let noDataCell = DataNotFoundTableViewCellModel(title: Strings.AddMoney.searchResults, description: Strings.AddMoney.searchResultsDescription, image: "search-status")
                dataSource.append(noDataCell)
            }
            return dataSource
        }
    }
    
    private var getPopularBanks: [AddMoneyMetaDataResponseModel.BankDataModel] {
        if type == .lean || type == .epg {
            if let popularBanks = GlobalData.shared.addMoneyMetaDataResponse?.data?.banksData?.popularBanks {
                return popularBanks.filter({$0.type == type.rawValue})
            }
        } else {
            if let popularBanks = GlobalData.shared.addMoneyMetaDataResponse?.data?.banksData?.popularBanks {
                return popularBanks
            }
        }
        return []
    }
    
    private var getBanksList: [AddMoneyMetaDataResponseModel.BankDataModel] {
        if type == .lean || type == .epg {
            if let popularBanks = GlobalData.shared.addMoneyMetaDataResponse?.data?.banksData?.banksList {
                return popularBanks.filter({$0.type == type.rawValue})
            }
        } else {
            if let popularBanks = GlobalData.shared.addMoneyMetaDataResponse?.data?.banksData?.banksList {
                return popularBanks
            }
        }
        return []
    }
}

// MARK: - Class Methods
extension AddMoneySelectBankPresenter {
    private func openAccountLinkingFlow() {
        if let selectedBank, let linkedAccountsList {
            if linkedAccountsList.contains(where: {$0.bankIdentifier == selectedBank.bankIdentifier}) {
                Alert.showBottomSheetError(title: Strings.AddMoney.alreadyLinked, message: Strings.AddMoney.thisBankIsAlreadyLinked, actionBtnTitle: Strings.AddMoney.gotIt)
                return
            }
        }
        
        self.connectBankAccount()
    }
}

// MARK: - Responses
extension AddMoneySelectBankPresenter: AddMoneySelectBankInteractorOutputProtocol {
    func onBankAccountsList(Response response: BankAccountsListResponseModel?) {
        Loader.shared.hideFullScreen()
        if let paymentsSources = response?.data?.paymentSources {
            self.linkedAccountsList = paymentsSources
        }
    }
    
    func onBankAccountsList(Error error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: Strings.Generic.error, message: error.errorDescription)
    }
    
}

// MARK: - Handle Lean States
extension AddMoneySelectBankPresenter: LeanSDKManagerDelegate {
    func dismissWithSuccess(status: LeanSDKStatusEnum) {
        print(status)
        self.router?.openSuccessConnectedAccountScreen()
    }
    
    func dismissWithError(status: LeanSDKStatusEnum) {
        switch status {
        case .Cancelled:
            break
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
extension AddMoneySelectBankPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        self.connectBankAccount()
    }
    
    func secondryBtnTapped() {
        self.router?.go(to: .loadLeanErrorTray)
    }
}
