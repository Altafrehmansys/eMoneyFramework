//
//  AllSavedBillsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation

class AllSavedBillsPresenter {

    // MARK: Properties

    weak var view: AllSavedBillsViewProtocol?
    var router: AllSavedBillsRouterProtocol?
    var interactor: AllSavedBillsInteractorProtocol?
    
    var tableViewDataSource: [StandardCellModel] = []
    var tableViewCellActions: StandardCellActions? = nil
    
    var collectionViewDataSource: [StandardCellModel] = []
    
    var allBills: [ListItems] = []
    
    var collectionViewCellActions: StandardCellActions? = nil
    var selectCollectViewModel:SingleTitleCollectionViewCellModel?
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case allPayments
            case mobilePostAndPrepaid
            case home
            case vehicles
            case international
            case government
            case other
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
}

extension AllSavedBillsPresenter: AllSavedBillsPresenterProtocol {
   
    func loadData() {
        view?.setupUI()
        
        self.setupTableViewCellActions()
        self.setupCollectionViewCellActions()
        self.makeTableViewDataSource()
        self.makeCollectionDataSource()
    }
    
    func makeTableViewDataSource() {
        
        self.tableViewDataSource = self.setAllBillsPaymentTableViewDataSource()
        if let methodType = selectCollectViewModel?.methodType as? MethodType {
            self.tableViewDataSource.removeAll()
            switch methodType.type {
            case .allPayments:
                self.tableViewDataSource = self.setAllBillsPaymentTableViewDataSource()
            case .mobilePostAndPrepaid:
                self.tableViewDataSource = self.setMobileBillTableViewDataSource()
            case .home:
                self.tableViewDataSource = self.setHomeTableViewDataSource()
            case .vehicles:
                self.tableViewDataSource = self.setVehiclesTableViewDataSource()
            case .international:
                self.tableViewDataSource = self.setInternationalTableViewDataSource()
            case .government:
                self.tableViewDataSource = self.setGovernmentTableViewDataSource()
            case .other:
                self.tableViewDataSource = self.setOtherTableViewDataSource()
            case .general:
                break
            }
        }
        
        view?.reloadTableView()
        
    }
    
    func makeCollectionDataSource() {
        
        self.collectionViewDataSource.removeAll()
        self.collectionViewDataSource = self.setCollectionDataSource()
        view?.reloadCollectionView()
    }
}

extension AllSavedBillsPresenter: AllSavedBillsInteractorOutputProtocol {
    
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func setupTableViewCellActions() {
        tableViewCellActions = StandardCellActions{ index, model in
            if let model = model as? MyBeneficiaryTableViewCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .allPayments :
                    break
                case .mobilePostAndPrepaid:
                    break
                case .home:
                   break
                case .vehicles:
                    break
                case .international:
                    break
                case .government:
                    break
                case .other:
                    break
                case .general:
                    break
                }
            }
            if let model = model as? SavedUtilityBillTableViewCellModel {
                self.moveToBillManagement()
            }
        }
    }
    private func setupCollectionViewCellActions() {
        collectionViewCellActions = StandardCellActions{ index, model in
            if let model = model as? SingleTitleCollectionViewCellModel{
                self.selectCollectViewModel = model
                self.makeTableViewDataSource()
            }
            
            self.view?.setSelectedCellColor(index: index)

        }
    }
    
    private func setAllBillsPaymentTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
  
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type:.allPayments))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type:.mobilePostAndPrepaid))
        
        dataSource.append(cell2)
        dataSource.append(dividerCell())
        
        let cell3 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .home))
        
        dataSource.append(cell3)
        dataSource.append(dividerCell())
        
        let cell4 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .vehicles))
        
        dataSource.append(cell4)
        dataSource.append(dividerCell())
        
        let cell5 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .government))
        dataSource.append(cell5)
        dataSource.append(dividerCell())
        
        let cell6 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .other))
        dataSource.append(cell6)
        
        return dataSource
    }
    private func setMobileBillTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
  

        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .mobilePostAndPrepaid))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .mobilePostAndPrepaid))
        
        dataSource.append(cell2)

        return dataSource
    }
    private func setHomeTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .home))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .home))
        
        dataSource.append(cell2)
        
        return dataSource
    }
    private func setVehiclesTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .vehicles))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .vehicles))
        
        dataSource.append(cell2)
        return dataSource
    }
    
    private func setInternationalTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .international))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .international))
        
        dataSource.append(cell2)
      
        
        return dataSource
    }
    
    private func setGovernmentTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .government))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .government))
        
        dataSource.append(cell2)
     
        
        return dataSource
    }
    private func setOtherTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let cell1 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .other))
        
        dataSource.append(cell1)
        dataSource.append(dividerCell())
        
        let cell2 = SavedUtilityBillTableViewCellModel(actions:self.tableViewCellActions,title: "Home electricity", subTitle: "Etihad water & electricity...",methodType: MethodType(type: .other))
        
        dataSource.append(cell2)
     
        
        return dataSource
    }
    
    
    private func setCollectionDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.removeAll()
        dataSource.append(SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title:Strings.BillPayment.allPayments))
        for bill in allBills {
            dataSource.append(SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title: bill.title ?? ""))
        }
        
        self.collectionViewDataSource = dataSource
        return dataSource
    }
    func moveToBillManagement() {
        self.router?.go(to: .billManagement)
    }
}


extension AllSavedBillsPresenter: AllSavedBillsInteractorProtocol {
    
}


// MARK: - Make Navigations
extension AllSavedBillsPresenter {
    func navigateToBankBeneficiary() {
       // self.router?.go(to:.bankBeneficiary)
    }
    func navigateToMobileBeneficiary() {
      //  self.router?.go(to:.mobileBeneficiary)
    }
    func navigateToEmployeeBeneficiary() {
       // self.router?.go(to:.employeeBeneficiary)
    }
}
