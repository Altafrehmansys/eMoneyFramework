//
//  SavedBillsDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 21/06/2023.
//  
//

import Foundation
import UIKit

class SavedBillsDetailsRouter {

    enum Route {
        
        case billManagement
        
        case mobilEtisalat(navTitle:String,selectedItem:ListItems?)
        case mobilDU(navTitle:String,selectedItem:ListItems?)
        case homeDEVA(navTitle:String,selectedItem:ListItems?)
        case homeISTA(navTitle:String,selectedItem:ListItems?)
        case homeLootahGas(navTitle:String,selectedItem:ListItems?)
        case vehicleDubaiTraficPoliceAndFine(navTitle:String,selectedItem:ListItems?)
        case vehicleMawaqif(navTitle:String,selectedItem:ListItems?)
        case internationalMobile(navTitle:String,selectedItem:ListItems?)
        case vehicleMParking(navTitle:String,selectedItem:ListItems?)
        case otherServiceISTARegistration(navTitle:String,selectedItem:ListItems?)
        case vehicleSalik(navTitle:String,selectedItem:ListItems?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle:String,bill:ListItems,billType:BillsAnsTopUpType) -> SavedBillsDetailsViewController {
        
        let viewController = SavedBillsDetailsViewController.instantiate(fromAppStoryboard: .SavedBillsDetails)
        let presenter = SavedBillsDetailsPresenter()
        let router = SavedBillsDetailsRouter()
        let interactor = SavedBillsDetailsInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.navTitle = navTitle
        presenter.bill = bill
        presenter.billType = billType
        router.view = viewController
        interactor.output = presenter
        return viewController
        
    }
}

extension SavedBillsDetailsRouter: SavedBillsDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
    
        case .billManagement:
            let vc = BillManagementRouter.setupModule()
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
        }
    }
}
