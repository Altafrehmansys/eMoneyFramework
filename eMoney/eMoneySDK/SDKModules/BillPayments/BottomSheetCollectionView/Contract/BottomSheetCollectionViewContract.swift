//
//  BottomSheetCollectionViewContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation

protocol BottomSheetCollectionViewViewProtocol: ViperView {
    
    var presenter: BottomSheetCollectionViewPresenterProtocol! { get set }
    func setupUI()
    func reloadCollectionView()
    
}

protocol BottomSheetCollectionViewPresenterProtocol: ViperPresenter {
    var collectionViewDataSource: [StandardCellModel] { get }
    var listItems:[ListItems] {get set}
    var title:String {get set}
    func loadData()
    func makeCollectionDataSource()
    func dismissView()
    
    func navigateToSavedBill(navTitle:String,bill:ListItems,billType:BillsAnsTopUpType)

    func navigateToMobileEtiSalat(navTitle:String,selectedItem:ListItems)
    func navigateToMobileDU(navTitle:String,selectedItem:ListItems)
    func navigateToDEWA(navTitle:String,selectedItem:ListItems)
    func navigateToISTA(navTitle:String,selectedItem:ListItems)
    func navigateToLootahGas(navTitle:String,selectedItem:ListItems)
    func navigateDubaiTraficFine(navTitle:String,selectedItem:ListItems)
    func navigateMawaqif(navTitle:String,selectedItem:ListItems)
    func navigateToInternationalMobile(navTitle:String,selectedItem:ListItems)
    func navigateToMParking(navTitle:String,selectedItem:ListItems)
    func navigateToISTARegistration(navTitle:String,selectedItem:ListItems)
    func navigateToSalik(navTitle:String,selectedItem:ListItems)
    
}

protocol BottomSheetCollectionViewInteractorProtocol: ViperInteractor {
    
}

protocol BottomSheetCollectionViewInteractorOutputProtocol: AnyObject {
}

protocol BottomSheetCollectionViewRouterProtocol: ViperRouter {
    func go(to route: BottomSheetCollectionViewRouter.Route)
}
