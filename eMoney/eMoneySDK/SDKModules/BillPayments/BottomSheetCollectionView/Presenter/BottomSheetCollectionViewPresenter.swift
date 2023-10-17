//
//  BottomSheetCollectionViewPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation

class BottomSheetCollectionViewPresenter {

    // MARK: Properties

    weak var view: BottomSheetCollectionViewViewProtocol?
    var router: BottomSheetCollectionViewRouterProtocol?
    var interactor: BottomSheetCollectionViewInteractorProtocol?
    var collectionViewDataSource: [StandardCellModel] = []
    var collectionViewCellActions: StandardCellActions? = nil
    var title:String = ""
    var listItems:[ListItems] = [ListItems]()
    var isSavedBills:Bool = true

}

extension BottomSheetCollectionViewPresenter: BottomSheetCollectionViewPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        self.setupCollectionViewCellActions()
        self.makeCollectionDataSource()
    }
    
    func makeCollectionDataSource() {
        self.collectionViewDataSource.removeAll()
        self.collectionViewDataSource = self.setCollectionDataSource()
        view?.reloadCollectionView()
    }
    
}

extension BottomSheetCollectionViewPresenter: BottomSheetCollectionViewInteractorOutputProtocol {
    
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func setupCollectionViewCellActions() {
        collectionViewCellActions = StandardCellActions{ index, model in
            if let model = model as? SavedBillCellModel {
                if let bill = model.listItems?[index] {
                    
                    switch BillsAnsTopUpType(rawValue:model.listItems?[index].codeId ?? "") {
                    case .mobilEtisalat:
                        
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .mobilEtisalat)
                        }else{
                            self.navigateToMobileEtiSalat(navTitle:self.title, selectedItem:bill)
                        }
                        
                    case .mobileDu:
                     
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .mobileDu)
                        }else{
                            self.navigateToMobileDU(navTitle:self.title, selectedItem:bill)
                        }
                        
                    case .homeDEWA:
        
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .homeDEWA)
                        }else{
                            self.navigateToDEWA(navTitle:self.title, selectedItem:bill)
                        }
                        
                    case .homeISTA:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .homeISTA)
                        }else{
                            self.navigateToISTA(navTitle:self.title, selectedItem:bill)
                        }
                    case.homeLootahGas:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .homeLootahGas)
                        }else{
                            self.navigateToLootahGas(navTitle:self.title, selectedItem:bill)
                        }
                    case .vehicleSalik:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .vehicleSalik)
                        }else{
                            self.navigateToSalik(navTitle:self.title, selectedItem:bill)
                        }
                    case .vehiclemParking:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .vehiclemParking)
                        }else{
                            self.navigateToMParking(navTitle:self.title, selectedItem:bill)
                        }
                    case .vehicleMawaqif:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .vehicleMawaqif)
                        }else{
                            self.navigateMawaqif(navTitle:self.title, selectedItem:bill)
                        }
                    case .vehicleTrafficFineDubaiPolice:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .vehicleTrafficFineDubaiPolice)
                        }else{
                            self.navigateDubaiTraficFine(navTitle:self.title, selectedItem:bill)
                        }
                    case .ipMobile:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .ipMobile)
                        }else{
                            self.navigateToInternationalMobile(navTitle:self.title, selectedItem:bill)
                        }
                    case .osISTARegistration:
                        if self.isSavedBills{
                            self.navigateToSavedBill(navTitle:self.title, bill:bill, billType: .osISTARegistration)
                        }else{
                            self.navigateToISTARegistration(navTitle:self.title, selectedItem:bill)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    private func setCollectionDataSource() -> [StandardCellModel] {

        var dataSource = [StandardCellModel]()
        for list in listItems {
            dataSource.append(SavedBillCellModel(actions:self.collectionViewCellActions, title:list.title ?? "", imgName:list.imageUrl ?? "",listItems: listItems))
        }
        return dataSource
    }
}

extension BottomSheetCollectionViewPresenter{
    
    func dismissView() {
        router?.go(to: .back)
    }
    func navigateToSavedBill(navTitle: String, bill: ListItems,billType:BillsAnsTopUpType) {
        self.router?.go(to:.savedBillsListing(navTitle: navTitle, bill: bill,billType: billType))
    }
    
    func navigateToMobileEtiSalat(navTitle:String,selectedItem:ListItems){
        self.router?.go(to: .mobilEtisalat(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToMobileDU(navTitle:String,selectedItem:ListItems) {
        self.router?.go(to: .mobilDU(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToDEWA(navTitle:String,selectedItem:ListItems) {
        self.router?.go(to: .homeDEVA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToISTA(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeISTA(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToLootahGas(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .homeLootahGas(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateDubaiTraficFine(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleDubaiTraficPoliceAndFine(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateMawaqif(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleMawaqif(navTitle: navTitle, selectedItem: selectedItem))
    }
    
    func navigateToInternationalMobile(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .internationalMobile(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToMParking(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleMParking(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToISTARegistration(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .otherServiceISTARegistration(navTitle: navTitle, selectedItem: selectedItem))
    }
    func navigateToSalik(navTitle: String, selectedItem: ListItems) {
        self.router?.go(to: .vehicleSalik(navTitle: navTitle, selectedItem: selectedItem))
    }
    
}
