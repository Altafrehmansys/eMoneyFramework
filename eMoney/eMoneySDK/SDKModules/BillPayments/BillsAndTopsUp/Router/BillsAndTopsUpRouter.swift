//
//  BillsAndTopsUpRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit

class BillsAndTopsUpRouter {

    enum Route {
        case allSavedBills(allBills:[ListItems])
        case dueBills
        case billManagement
        case bottomSheetWithBillsListItems(title:String,dataSource:[ListItems])
        
        // all Bill type
        case search(allBills:[ListItems])
        case mobilEtisalat(navTitle:String,selectedItem:ListItems)
        case mobilDU(navTitle:String,selectedItem:ListItems)
        case homeDEVA(navTitle:String,selectedItem:ListItems)
        case homeISTA(navTitle:String,selectedItem:ListItems)
        case homeLootahGas(navTitle:String,selectedItem:ListItems)
        
        case homeSEWA(navTitle:String,selectedItem:ListItems)
        case homeAADC(navTitle:String,selectedItem:ListItems)
        case homeADDC(navTitle:String,selectedItem:ListItems)
        case homeEtihadWaterAndElectricity(navTitle:String,selectedItem:ListItems)
        case homeAjmanSewerage(navTitle:String,selectedItem:ListItems)
        case homeSERGAS(navTitle:String,selectedItem:ListItems)
        
        case homeEtisalat(navTitle:String,selectedItem:ListItems)
        case homeDU(navTitle:String,selectedItem:ListItems)
        
        
        case vehicleDubaiTraficPoliceAndFine(navTitle:String,selectedItem:ListItems)
        case vehicleMawaqif(navTitle:String,selectedItem:ListItems)
        case internationalMobile(navTitle:String,selectedItem:ListItems)
        case vehicleMParking(navTitle:String,selectedItem:ListItems)
        case otherServiceISTARegistration(navTitle:String,selectedItem:ListItems)
        case vehicleSalik(navTitle:String,selectedItem:ListItems)
      
        case governmentAjmanPay(navTitle:String,selectedItem:ListItems)
        case otherServiceNationalBonds(navTitle:String,selectedItem:ListItems)
             
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(isSavedBill:Bool = false) -> BillsAndTopsUpViewController {
        let viewController = BillsAndTopsUpViewController.instantiate(fromAppStoryboard: .BillsAndTopsUp)
        let presenter = BillsAndTopsUpPresenter()
        let router = BillsAndTopsUpRouter()
        let interactor = BillsAndTopsUpInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.isSavedBills = isSavedBill
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillsAndTopsUpRouter: BillsAndTopsUpRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
            
        case .allSavedBills(let allBills):
            let vc = AllSavedBillsRouter.setupModule(allBills: allBills)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .dueBills:
            let vc = DueBillsRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .billManagement:
            let vc = BillManagementRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .bottomSheetWithBillsListItems(let title,let listItems):
            let bottomSheet = BottomSheetCollectionViewRouter.setupModule(title:title,listItems: listItems)
            bottomSheet.hidesBottomBarWhenPushed = true
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
            
        case .search(let allBills):
            let vc = BillPaymentSearchRouter.setupModule(allBills: allBills)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .mobilEtisalat(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.mobilEtisalat)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .mobilDU(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.mobileDu)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .homeDEVA(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeDEWA)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeISTA(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeISTA)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeLootahGas(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeLootahGas)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)

        case .vehicleDubaiTraficPoliceAndFine(let navTitle,let selectedItem):
            let vc = VehiclesAndTransportDetailRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleTrafficFineDubaiPolice)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .vehicleMawaqif(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleMawaqif)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .internationalMobile(let navTitle,let selectedItem):
            let vc = BillSelectProviderRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType: .ipMobile)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)

        case .vehicleMParking(let navTitle,let selectedItem):
            let vc = RecentParkingRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType: .vehiclemParking)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .otherServiceISTARegistration(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.osISTARegistration)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .vehicleSalik(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleSalik)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeSEWA(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeSEWA)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeAADC(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeAADC)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeADDC(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeADDC)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeEtihadWaterAndElectricity(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeEtihadWaterAndElectricity)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeAjmanSewerage(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeAjmanSewerage)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeSERGAS(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeAjmanSewerage)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .governmentAjmanPay(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.govtAjmanPay)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .otherServiceNationalBonds(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.osNationalbonds)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
            
        case .homeEtisalat(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeEtisalatELife)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .homeDU(let navTitle,let selectedItem):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeDu)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
