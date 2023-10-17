//
//  BillsAndTopsUpContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

protocol BillsAndTopsUpViewProtocol: ViperView {

    var presenter: BillsAndTopsUpPresenterProtocol! { get set }
    func setupUI()
    func reloadCollectionView()
    func reloadTableView()
     
}

protocol BillsAndTopsUpPresenterProtocol: ViperPresenter {

    var collectionViewDataSource: [ListItems] { get }
    var tableViewDataSource: [StandardCellModel] { get }
    
    var isSavedBills:Bool { get set }

    func loadData()

    func navigateToAddMobileBill()
   
    func moveToAllSavedBills()
    func moveToPayAllDueBill()
    func moveToBillManagement()
    
    
    func loadBillsListItemBottomSheet(title:String,listItems:[ListItems])
    
    
    
    // For All bill type
    func navigateToSearch()
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
    
    func navigateToSEWA(navTitle:String,selectedItem:ListItems)
    func navigateToAADC(navTitle:String,selectedItem:ListItems)
    func navigateToADDC(navTitle:String,selectedItem:ListItems)
    func navigateToEtihadWaterAndElectricity(navTitle:String,selectedItem:ListItems)
    func navigateToAjmanSewerage(navTitle:String,selectedItem:ListItems)
    func navigateToSERGAS(navTitle:String,selectedItem:ListItems)
    func navigateToAjmanPay(navTitle:String,selectedItem:ListItems)
    func navigateToNationalBonds(navTitle:String,selectedItem:ListItems)
    
    func navigateToHomeEtisalat(navTitle:String,selectedItem:ListItems)
    func navigateToHomeDU(navTitle:String,selectedItem:ListItems)
    
   
   
   
   
}

protocol BillsAndTopsUpInteractorProtocol: ViperInteractor {
    func getBillsList()
    func getSavedBills()

}

protocol BillsAndTopsUpInteractorOutputProtocol: AnyObject {
    
    func onAllBillsList(Response response: BillsAndTopsUpResponseModel?)
    func onAllBillsList(Error error: AppError)
    
    func onSavedBillsList(Response response: BillsAndTopsUpResponseModel?)
    func onSavedBillsList(Error error: AppError)

}

protocol BillsAndTopsUpRouterProtocol: ViperRouter {
    func go(to route: BillsAndTopsUpRouter.Route)
}
