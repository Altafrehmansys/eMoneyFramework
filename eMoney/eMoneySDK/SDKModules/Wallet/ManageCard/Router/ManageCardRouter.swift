//
//  ManageCardRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//  
//

import Foundation
import UIKit

class ManageCardRouter {

    enum Route {
        case orderCard
        case changeCardPIN
        case reportLostCard
        case cancelCardBottomSheet(dataSource: [StandardCellModel], actions: [BaseButton])
        case navigateToCancelCard
        case navigateToCarsAccountLimits
        case loadFreezCardBottomSheet(dataSource: [StandardCellModel], actions: [BaseButton])
        
        case loadAddAutoMoneyBottomSheet(dataSource: [StandardCellModel], actions: [BaseButton])
    }
    
    // MARK: Properties

    weak var view: UIViewController?
    weak var genericBottomSheet: UIViewController?
    // MARK: Static methods

    static func setupModule() -> ManageCardViewController {
        let viewController = ManageCardViewController.instantiate(fromAppStoryboard: .ManageCard)
        let presenter = ManageCardPresenter()
        let router = ManageCardRouter()
        let interactor = ManageCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ManageCardRouter: ManageCardRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .orderCard:
//            let vc = DeliveryDetailsRouter.setupModule()
//            self.view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .changeCardPIN:
            let vc = EnterYourPINRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .reportLostCard:
//            let vc = ReportLostCardRouter.setupModule()
//            vc.hidesBottomBarWhenPushed = true
//            self.view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .cancelCardBottomSheet(let dataSource,let actions):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        case .navigateToCancelCard:
//            UIApplication.getTopViewController()?.dismiss(animated: true,completion: {
//                let vc = CancelCardRouter.setupModule()
//                vc.hidesBottomBarWhenPushed = true
//                self.view?.navigationController?.pushViewController(vc, animated: true)
//            })
            break
        case .navigateToCarsAccountLimits:
            let vc = CardAccountLimitsRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .loadFreezCardBottomSheet(let dataSource,let actions):
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case .loadAddAutoMoneyBottomSheet(let dataSource,let actions):
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        
        }
    }
}
