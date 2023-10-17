//
//  HomeScreenPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

final class HomeScreenPresenter: HomeScreenPresenterProtocol {
   
    
    var dataSource: [StandardCellModel]
    var cellAction: StandardCellActions?

    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case sendMoney
            case billAndTopsUp
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
    
    
    // MARK: - Attributes
    weak var view: HomeScreenViewProtocol?
    var interactor: HomeScreenInteractorProtocol
    var router: HomeScreenRouterProtocol
    var currentItem = 0
    
    var balanceData:AvailableBalanceData?
    
    init(view: HomeScreenViewProtocol, interactor: HomeScreenInteractorProtocol, router: HomeScreenRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        
        self.dataSource = [StandardCellModel]()
    }
    
    func viewDidLoad() {
        view?.setupUI()
        if GlobalData.shared.userProfile == .amlUnverified {
            router.go(to: .showAMLUnverifiedScreen)
            return
        }
        self.setupCellActions()
        self.makeDataSource()
    }
    
    func getAvailableBalance(){
        interactor.getAvailableBalance()
    }
}

// MARK: - Prepare Data Source
extension HomeScreenPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        let cardsCellModel = CardTableViewCellModel(actions: cellAction, title: "", balance: self.balanceData)
        dataSource.append(cardsCellModel)
        addSpaceCell(with: 24)
        
        let browseServiceDataSource = [ServiceCollectionViewCellModel(name: "Send money", image: "empty-wallet-add",methodType:MethodType(type: .sendMoney)),
                                       ServiceCollectionViewCellModel(actions:self.cellAction,name: "Bills & Top ups", image: "empty-wallet-add",methodType:MethodType(type: .billAndTopsUp)),
                      ServiceCollectionViewCellModel(name: "Send abroad", image: "empty-wallet-add"),
                      ServiceCollectionViewCellModel(name: "Gift shop", image: "empty-wallet-add"),
                      ServiceCollectionViewCellModel(name: "Donations & Zakat", image: "empty-wallet-add"),
                      ServiceCollectionViewCellModel(name: "Send money", image: "empty-wallet-add"),
                      ServiceCollectionViewCellModel(name: "Send money", image: "empty-wallet-add")]
        
        let browseCellModel = BrowseServicesTableViewCellModel(actions:self.cellAction,title: "Browse services",
                                                               dataSource: browseServiceDataSource,
                                                               itemSize: CGSize(width: 64, height: 98),
                                                               interItemSpacing: 12)
        dataSource.append(browseCellModel)
        
        if let profile = GlobalData.shared.userProfile, profile == .physicalKYC {
            let cellModel = SendMoneyAbroadCellModel(actions: cellAction, title: "Send money abroad", cellState: .transferring)
            dataSource.append(cellModel)
        }else{
            let cellModel = SendMoneyAbroadCellModel(actions: cellAction, title: "Send money abroad", cellState: .selectCountry)
            dataSource.append(cellModel)
        }
        
        
        addPayYourBillCell()
        addManageYourBillsCell()
        addSpaceCell(with: 24)
        addEAndMoneyCell()
        
        
        view?.reloadData()
    }
    
    private func addPayYourBillCell() {
        let payBillDataSource = [
            PayBillsServicesCollectionViewCellModel(name: "Etisalat", image: "etisalat"),
            PayBillsServicesCollectionViewCellModel(name: "Du", image: "du"),
            PayBillsServicesCollectionViewCellModel(name: "DEWA", image: "diwa"),
            PayBillsServicesCollectionViewCellModel(name: "Etihad", image: "etihad"),
            PayBillsServicesCollectionViewCellModel(name: "Salik", image: "salik"),
            PayBillsServicesCollectionViewCellModel(name: "More", image: "more")
        ]
        let payYourBillCellModel = BrowseServicesTableViewCellModel(title: "Pay your bills",
                                                                    dataSource: payBillDataSource,
                                                                    itemSize: CGSize(width: 36, height: 57),
                                                                    interItemSpacing: 20)
        dataSource.append(payYourBillCellModel)
    }
    
    private func addManageYourBillsCell() {
        
        let addNewBillDataSource = [
            PayBillsServicesCollectionViewCellModel(name: "Etisalat", image: "etisalat"),
            PayBillsServicesCollectionViewCellModel(name: "Du", image: "du"),
            PayBillsServicesCollectionViewCellModel(name: "DEWA", image: "diwa"),
            PayBillsServicesCollectionViewCellModel(name: "Etihad", image: "etihad"),
            PayBillsServicesCollectionViewCellModel(name: "Salik", image: "salik"),
            PayBillsServicesCollectionViewCellModel(name: "More", image: "more")
        ]
        let addNewBillCellModel = BrowseServicesTableViewCellModel(title: "Add new bill or recharge",
                                                                   titleFont: AppFont.appMedium(size: .body4),
                                                                   dataSource: addNewBillDataSource,
                                                                   itemSize: CGSize(width: 36, height: 57),
                                                                   interItemSpacing: 20)
        
        let upcomingBillsTitleCellModel = GenericSingleLabelCellModel(content: "Or pay upcoming bills", font: AppFont.appMedium(size: .body4))
        
        let upcomingBillCellModel = UpcomingBillCellModel(image: "etisalat", title: "My mobile", serviceName: "Etisalat prepaid", lastRechargedDate: "Last recharged Feb 02")
        let upcomingBillCellModel1 = UpcomingBillCellModel(image: "etihad", title: "House Jumairah", serviceName: "Etihad water &... | AED 226.00", lastRechargedDate: "", isOverDue: true)
        let upcomingBillCellModel2 = UpcomingBillCellModel(image: "salik", title: "43517253", serviceName: "Salik", lastRechargedDate: "Last recharged Feb 02", isSeparatorHidden: true)
        
        let buttonCellModel = SingleButtonTableViewCellModel(actions: cellAction, title: "Pay all & recharge", type: .GradientButton)
        
        let manageYourBillsDataSource: [StandardCellModel] = [
            addNewBillCellModel,
            upcomingBillsTitleCellModel,
            upcomingBillCellModel,
            upcomingBillCellModel1,
            upcomingBillCellModel2,
            buttonCellModel
        ]
        let cellModel = ManageYourBillsTableViewCellModel(title: "Manage your bills", dataSource: manageYourBillsDataSource)
        dataSource.append(cellModel)
    }
    
    private func addEAndMoneyCell() {
        let eAndMoneyDataSource = [
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111"),
            CountryFlagCollectionViewCellModel(flagImage: "111")
        ]
        let exploreEAndMoney = BrowseServicesTableViewCellModel(actions: cellAction,
                                                                title: "Explore e& money ",
                                                                dataSource: eAndMoneyDataSource,
                                                                itemSize: CGSize(width: 200, height: 200),
                                                                interItemSpacing: 12,
                                                                isPagingEnabled: true)
        dataSource.append(exploreEAndMoney)
        
        let cellModel = PageControlCellModel(currentPage: 0, totalPages: eAndMoneyDataSource.count)
        dataSource.append(cellModel)
    }
    
    private func addSpaceCell(with space: CGFloat) {
        let cellModel = SpaceTableViewCellModel(height: space)
        dataSource.append(cellModel)
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions { [weak self] (index, model) in
            
            if let _ = model as? CardTableViewCellModel {
                if GlobalData.shared.isUpgradeRequired {
                    KYCBottomSheet.shared.present()
                } else {
                    self?.navigateToAddMoney()
                }
            }
            
            if let _ = model as? BrowseServicesTableViewCellModel {
                if let cellIndex = self?.dataSource.firstIndex(where: {$0 is PageControlCellModel}) {
                    (self?.dataSource[cellIndex] as? PageControlCellModel)?.currentPage = index
                    self?.view?.reloadData()
                }
            }
            
            if let cellModel = model as? SendMoneyAbroadCellModel {
                self?.updateDataSource(state: cellModel.cellState == .transferring ? .selectCountry : .transferring)
            }
            
    
            if let browseCellModel = model as? ServiceCollectionViewCellModel, let methodType = browseCellModel.methodType as? MethodType {
                switch methodType.type {
                case .sendMoney:
                    self?.navigateToSendMoney()
                case .billAndTopsUp:
                    self?.navigateToBillsAndTopsUp()
                case .general:
                    break
                }
            }
        }
    }
    
    private func updateDataSource(state: SendMoneyAbroadCellModel.CurrentState) {
        if let index = dataSource.firstIndex(where: {$0 is SendMoneyAbroadCellModel}) {
            (dataSource[index] as? SendMoneyAbroadCellModel)?.cellState = state
            view?.reloadData()
        }
    }
}

// MARK: - Make Navigations
extension HomeScreenPresenter {
    
    func navigateToSendMoney() {
        self.router.go(to: .sendMoney)
    }
    
    func navigateToBillsAndTopsUp() {
        self.router.go(to: .BillsAndTopsUp)
    }
    
    func navigateToAddMoney() {
        if let profile = GlobalData.shared.userProfile, profile == .noKYC {
            // Show Bottom Alert for NO KYC
            return
        }
        self.router.go(to: .addMoney)
    }
    
}

// MARK: - Interactor Output Protocol
extension HomeScreenPresenter: HomeScreenInteractorOutputProtocol {
    func onAvailableBalanceResponse(response: AvailableBalanceResponse?) {
        if let data = response?.data {
            GlobalData.shared.availableBalance = data
            balanceData = data
            makeDataSource()
        }
    }
    
    func onAvailableBalanceError(error: AppError) {
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.errorDescription)
    }
}
