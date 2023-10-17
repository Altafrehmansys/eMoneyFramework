//
//  SavedBillsDetailsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 21/06/2023.
//  
//

import Foundation

class SavedBillsDetailsPresenter {

    // MARK: Properties

    weak var view: SavedBillsDetailsViewProtocol?
    var router: SavedBillsDetailsRouterProtocol?
    var interactor: SavedBillsDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var billType: BillsAnsTopUpType = .none
    var navTitle: String = ""
    var bill: ListItems? = nil
    
}

extension SavedBillsDetailsPresenter: SavedBillsDetailsPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
    func makeDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.setDataSource()
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
            if let _ = model as? AddNewBillTableViewCellModel {
                switch self.billType {
                case .mobilEtisalat:
                    self.navigateToMobileEtiSalat(navTitle: self.navTitle, selectedItem: self.bill)
                case .mobileDu:
                    self.navigateToMobileDU(navTitle: self.navTitle, selectedItem: self.bill)
                case .homeDEWA:
                    self.navigateToDEWA(navTitle: self.navTitle, selectedItem: self.bill)
                case .homeISTA:
                    self.navigateToISTA(navTitle: self.navTitle, selectedItem:self.bill)
                case .homeLootahGas:
                    self.navigateToLootahGas(navTitle: self.navTitle, selectedItem:self.bill)
                case .vehicleSalik:
                    self.navigateToSalik(navTitle: self.navTitle, selectedItem: self.bill)
                case .vehiclemParking:
                    self.navigateToMParking(navTitle: self.navTitle, selectedItem: self.bill)
                case .vehicleMawaqif:
                    self.navigateMawaqif(navTitle: self.navTitle, selectedItem: self.bill)
                case .vehicleTrafficFineDubaiPolice:
                    self.navigateDubaiTraficFine(navTitle: self.navTitle, selectedItem: self.bill)
                case .ipMobile:
                    self.navigateToInternationalMobile(navTitle: self.navTitle, selectedItem: self.bill)
                case .osISTARegistration:
                    self.navigateToISTARegistration(navTitle: self.navTitle, selectedItem: self.bill)
                default:
                    break
                }
            }
            if let model = model as? SavedUtilityBillTableViewCellModel{
                self.navigateToBillManagement()
            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(BillAccountDetailCellModel(imageURL:bill?.imageUrl ?? "", title:bill?.title ?? ""))
        var childData1 = [StandardCellModel]()
        childData1.append(spaceCell(with: 12))
        
        childData1.append(SavedUtilityBillTableViewCellModel(actions:self.cellActions,title: "Abdullah Mohammed", subTitle: "Etisalat prepaid"))
        
        childData1.append(dividerCell())
        
        childData1.append( SavedUtilityBillTableViewCellModel(actions: self.cellActions,title: "Abdullah Mohammed", subTitle: "Etisalat prepaid"))
        childData1.append(spaceCell(with: 12))
        let data = TableViewCellModelWithUITableView(dataSource: childData1, borderWidth: 1, borderColor: AppColor.eAnd_Grey_30, cornerRadius: 12, leftSpace: 24, rightSpace: 24, topSpace: 12, bottomSpace: 12)
        dataSource.append(data)
        
        dataSource.append(TableViewCellModelWithUITableView(dataSource: [AddNewBillTableViewCellModel(actions: self.cellActions,image: "add-new-beneficiary", title:Strings.BillPayment.addNewAccount)], borderWidth: 1, borderColor: AppColor.eAnd_Grey_30, cornerRadius: 12, leftSpace: 24, rightSpace: 24, topSpace: 12, bottomSpace: 12))
        return dataSource
    }
}

extension SavedBillsDetailsPresenter: SavedBillsDetailsInteractorOutputProtocol {
    
}

extension SavedBillsDetailsPresenter{
    
   
    func navigateToBillManagement() {
        self.router?.go(to: .billManagement)
    }
    func navigateToMobileEtiSalat(navTitle:String,selectedItem:ListItems?){
        self.router?.go(to: .mobilEtisalat(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToMobileDU(navTitle:String,selectedItem:ListItems?) {
        self.router?.go(to: .mobilDU(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToDEWA(navTitle:String,selectedItem:ListItems?) {
        self.router?.go(to: .homeDEVA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToISTA(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .homeISTA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToLootahGas(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .homeLootahGas(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateDubaiTraficFine(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .vehicleDubaiTraficPoliceAndFine(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateMawaqif(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .vehicleMawaqif(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToInternationalMobile(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .internationalMobile(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToMParking(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .vehicleMParking(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToISTARegistration(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .otherServiceISTARegistration(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToSalik(navTitle: String, selectedItem: ListItems?) {
        self.router?.go(to: .vehicleSalik(navTitle: navTitle, selectedItem: selectedItem))
    }
    
}
