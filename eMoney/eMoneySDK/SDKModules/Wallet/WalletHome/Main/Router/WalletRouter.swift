//
//  WalletRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation
import UIKit

class WalletRouter {

    enum Route {
        
        case loadCardBottomSheetView(dataSource:[StandardCellModel],actions:[BaseButton])
        case loadBankBottomSheetView(dataSource:[StandardCellModel],actions:[BaseButton])
        case remove(dataSource: [StandardCellModel], actions: [BaseButton])
        case navigateToCardDetail
    }
    
    // MARK: Properties

    weak var view: UIViewController?
    weak var genericBottomSheet: UIViewController?
    
    // MARK: Static methods

    static func setupModule() -> WalletViewController {
        let viewController = WalletViewController.instantiate(fromAppStoryboard: .Wallet)
        let presenter = WalletPresenter()
        let router = WalletRouter()
        let walletServices = WalletServices()
        let interactor = WalletInteractor(service: walletServices)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension WalletRouter: WalletRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
            
        case .loadCardBottomSheetView(let dataSource,let actions):
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.tabBarController?.present(bottomSheet, animated: true)
            
        case .loadBankBottomSheetView(let dataSource,let actions):
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            self.genericBottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            self.genericBottomSheet!.modalPresentationStyle = .overCurrentContext
            self.view?.tabBarController?.present(  self.genericBottomSheet!, animated: true)
            
        case .remove(let dataSource,let actions):
            
            self.genericBottomSheet?.dismiss(animated: true, completion: {
                let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource, actionButtons: actions)
                self.genericBottomSheet = GenericBottomSheetRouter.setupModule(input: input)
                self.genericBottomSheet?.modalPresentationStyle = .overCurrentContext
                self.view?.tabBarController?.present(self.genericBottomSheet!, animated: true)
            })
            
        case .navigateToCardDetail:
            let vc = CardDetailsRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
