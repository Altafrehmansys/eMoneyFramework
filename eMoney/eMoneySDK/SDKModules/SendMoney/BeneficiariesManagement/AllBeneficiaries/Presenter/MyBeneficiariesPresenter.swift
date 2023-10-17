//
//  MyBeneficiariesPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/05/2023.
//  
//

import Foundation

class MyBeneficiariesPresenter {

    // MARK: Properties

    weak var view: MyBeneficiariesViewProtocol?
    var router: MyBeneficiariesRouterProtocol?
    var interactor: MyBeneficiariesInteractorProtocol?
    
    var tableViewDataSource: [StandardCellModel] = []
    var tableViewCellActions: StandardCellActions? = nil
    
    var collectionViewDataSource: [StandardCellModel] = []
    var collectionViewCellActions: StandardCellActions? = nil
    var selectCollectViewModel:SingleTitleCollectionViewCellModel?
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case all
            case bank
            case mobile
            case employee
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
}


extension MyBeneficiariesPresenter: MyBeneficiariesPresenterProtocol {
   
   
    func loadData() {
        view?.setupUI()
        self.setupTableViewCellActions()
        self.setupCollectionViewCellActions()
        self.makeTableViewDataSource()
        self.makeCollectionDataSource()
    }
    
    func makeTableViewDataSource() {
        
        self.tableViewDataSource = self.setAllBeneficiariesTableViewDataSource()
        if let methodType = selectCollectViewModel?.methodType as? MethodType {
            self.tableViewDataSource.removeAll()
            switch methodType.type {
            case .all:
                self.tableViewDataSource = self.setAllBeneficiariesTableViewDataSource()
            case .bank:
                self.tableViewDataSource = self.setBankTableViewDataSource()
            case .mobile:
                self.tableViewDataSource = self.setMobileTableViewDataSource()
            case .employee:
                self.tableViewDataSource = self.setEmployeeTableViewDataSource()
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

extension MyBeneficiariesPresenter: MyBeneficiariesInteractorOutputProtocol {
    
    
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
                case .all :
                    break
                case .bank:
                    self.navigateToBankBeneficiary()
                case .mobile:
                    self.navigateToMobileBeneficiary()
                case .employee:
                    self.navigateToEmployeeBeneficiary()
                case .general:
                    break
                }
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
    
    private func setAllBeneficiariesTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
  
        let myBeneficiary = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: true, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873", tagTitle: "Employee",methodType: MethodType(type: .employee))
        dataSource.append(myBeneficiary)
        dataSource.append(dividerCell())
        
        let myBeneficiary1 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .bank))
        dataSource.append(myBeneficiary1)
        dataSource.append(dividerCell())
        
        let myBeneficiary2 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .bank))
        dataSource.append(myBeneficiary2)
        
        dataSource.append(dividerCell())
        let myBeneficiary3 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: true, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873", tagTitle: "Employee",methodType: MethodType(type: .employee))
        dataSource.append(myBeneficiary3)
        dataSource.append(dividerCell())
        
        let myBeneficiary4 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .mobile))
        dataSource.append(myBeneficiary4)
        dataSource.append(dividerCell())
        
        let myBeneficiary5 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .mobile))
        dataSource.append(myBeneficiary5)
       
        return dataSource
    }
    private func setBankTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
  
        let myBeneficiary = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .bank))
        dataSource.append(myBeneficiary)
        dataSource.append(dividerCell())
        
        let myBeneficiary1 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .bank))
        dataSource.append(myBeneficiary1)

        return dataSource
    }
    private func setMobileTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let myBeneficiary = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Muhammad Yousaf", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .mobile))
        dataSource.append(myBeneficiary)
        dataSource.append(dividerCell())
        
        let myBeneficiary1 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: false, profileImage: "profile-image", title: "Muhammad Ahmed", subTitle: "AB 00 ABCHS 123213 1632873",methodType: MethodType(type: .mobile))
        dataSource.append(myBeneficiary1)
        
        return dataSource
    }
    private func setEmployeeTableViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        
        let myBeneficiary = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: true, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873", tagTitle: "Employee",methodType: MethodType(type: .employee))
        dataSource.append(myBeneficiary)
        dataSource.append(dividerCell())
        
        let myBeneficiary1 = MyBeneficiaryTableViewCellModel(actions: self.tableViewCellActions,isEmployee: true, profileImage: "profile-image", title: "Khan Mohammed", subTitle: "AB 00 ABCHS 123213 1632873", tagTitle: "Employee",methodType: MethodType(type: .employee))
        dataSource.append(myBeneficiary1)
        dataSource.append(dividerCell())
        
        return dataSource
    }
    
    
    private func setCollectionDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        let data = SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title: "All beneficiaries",methodType: MethodType(type: .all))
        dataSource.append(data)
        
        let data1 = SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title: "Bank",methodType: MethodType(type: .bank))
        dataSource.append(data1)
        
        let data2 = SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title: "Mobile",methodType: MethodType(type: .mobile))
        dataSource.append(data2)
        
        let data3 = SingleTitleCollectionViewCellModel(actions: self.collectionViewCellActions,title: "Employee",methodType: MethodType(type: .employee))
        dataSource.append(data3)
    
        return dataSource
    }
}

// MARK: - Make Navigations
extension MyBeneficiariesPresenter {
    func navigateToBankBeneficiary() {
        self.router?.go(to:.bankBeneficiary)
    }
    func navigateToMobileBeneficiary() {
        self.router?.go(to:.mobileBeneficiary)
    }
    func navigateToEmployeeBeneficiary() {
        self.router?.go(to:.employeeBeneficiary)
    }
}
