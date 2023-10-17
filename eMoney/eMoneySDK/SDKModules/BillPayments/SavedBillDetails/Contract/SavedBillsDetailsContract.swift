//
//  SavedBillsDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 21/06/2023.
//  
//

import Foundation

protocol SavedBillsDetailsViewProtocol: ViperView {
    
    var presenter: SavedBillsDetailsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol SavedBillsDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var navTitle:String {get set}
    var bill:ListItems? {get set}
    var billType:BillsAnsTopUpType { get set }
    func loadData()
    func makeDataSource()
    func navigateToBillManagement()
    func navigateToMobileEtiSalat(navTitle:String,selectedItem:ListItems?)
    func navigateToMobileDU(navTitle:String,selectedItem:ListItems?)
    func navigateToDEWA(navTitle:String,selectedItem:ListItems?)
    func navigateToISTA(navTitle:String,selectedItem:ListItems?)
    func navigateToLootahGas(navTitle:String,selectedItem:ListItems?)
    func navigateDubaiTraficFine(navTitle:String,selectedItem:ListItems?)
    func navigateMawaqif(navTitle:String,selectedItem:ListItems?)
    func navigateToInternationalMobile(navTitle:String,selectedItem:ListItems?)
    func navigateToMParking(navTitle:String,selectedItem:ListItems?)
    func navigateToISTARegistration(navTitle:String,selectedItem:ListItems?)
    func navigateToSalik(navTitle:String,selectedItem:ListItems?)
    
    
}

protocol SavedBillsDetailsInteractorProtocol: ViperInteractor {
    
}

protocol SavedBillsDetailsInteractorOutputProtocol: AnyObject {
}

protocol SavedBillsDetailsRouterProtocol: ViperRouter {
    func go(to route: SavedBillsDetailsRouter.Route)
}
