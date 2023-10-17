//
//  BottomSheetCollectionViewRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation
import UIKit

class BottomSheetCollectionViewRouter {
    
    enum Route {
        case back
        case savedBillsListing(navTitle:String,bill:ListItems,billType:BillsAnsTopUpType)
        
        case mobilEtisalat(navTitle:String,selectedItem:ListItems)
        case mobilDU(navTitle:String,selectedItem:ListItems)
        case homeDEVA(navTitle:String,selectedItem:ListItems)
        case homeISTA(navTitle:String,selectedItem:ListItems)
        case homeLootahGas(navTitle:String,selectedItem:ListItems)
        case vehicleDubaiTraficPoliceAndFine(navTitle:String,selectedItem:ListItems)
        case vehicleMawaqif(navTitle:String,selectedItem:ListItems)
        case internationalMobile(navTitle:String,selectedItem:ListItems)
        case vehicleMParking(navTitle:String,selectedItem:ListItems)
        case otherServiceISTARegistration(navTitle:String,selectedItem:ListItems)
        case vehicleSalik(navTitle:String,selectedItem:ListItems)
        
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    private var homeViewController: BaseNavigationController? {
        get {
            guard let tabbar = self.view?.presentingViewController as? CustomTabbarViewController, let homeVC = tabbar.viewControllers?.last as? BaseNavigationController else {
                return nil
            }
            return homeVC
        }
    }
    
    // MARK: Static methods
    
    static func setupModule(title:String,listItems:[ListItems]) -> BottomSheetCollectionViewViewController {
        let viewController = BottomSheetCollectionViewViewController.instantiate(fromAppStoryboard: .BottomSheetCollectionView)
        let presenter = BottomSheetCollectionViewPresenter()
        let router = BottomSheetCollectionViewRouter()
        let interactor = BottomSheetCollectionViewInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.listItems = listItems
        presenter.title = title
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension BottomSheetCollectionViewRouter: BottomSheetCollectionViewRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.dismiss(animated: true)
        case .savedBillsListing(let navTitle,let bill,let billType):
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = SavedBillsDetailsRouter.setupModule(navTitle: navTitle, bill: bill,billType:billType)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .mobilEtisalat(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.mobilEtisalat)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .mobilDU(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.mobileDu)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .homeDEVA(let navTitle,let selectedItem):
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeDEWA)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .homeISTA(let navTitle,let selectedItem):
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeISTA)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .homeLootahGas(let navTitle,let selectedItem):
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.homeLootahGas)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .vehicleDubaiTraficPoliceAndFine(let navTitle,let selectedItem):
          
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = VehiclesAndTransportDetailRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleTrafficFineDubaiPolice)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .vehicleMawaqif(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleMawaqif)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .internationalMobile(let navTitle,let selectedItem):
           
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillSelectProviderRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType: .ipMobile)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .vehicleMParking(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = RecentParkingRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType: .vehiclemParking)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .otherServiceISTARegistration(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.osISTARegistration)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
            
        case .vehicleSalik(let navTitle,let selectedItem):
            
            self.view?.dismiss(animated: true,completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillAccountDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType:.vehicleSalik)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
}
