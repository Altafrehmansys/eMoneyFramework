//
//  WalletCheckoutRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class WalletCheckoutRouter {
    
    enum Route {
        case requestCardSuccess
        case addPromo(input:GenericBottomSheetRouter.RouterInput? = nil)
        case showPromoApplied(input:GenericBottomSheetRouter.RouterInput? = nil)
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(input:BillAccountDetailsParameters) -> WalletCheckoutViewController {
        let viewController = WalletCheckoutViewController.instantiate(fromAppStoryboard: .WalletCheckout)
        let presenter = WalletCheckoutPresenter()
        let router = WalletCheckoutRouter()
        let interactor = WalletCheckoutInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.billInput = input
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}

extension WalletCheckoutRouter: WalletCheckoutRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .requestCardSuccess:
            let vc = WalletCardSuccessRouter.setupModule()
            vc.modalPresentationStyle = .fullScreen
            self.view?.navigationController?.present(vc, animated: true)
            
        case let .addPromo(input):
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            self.view?.navigationController?.present(vc, animated: true)
        case let .showPromoApplied(input):
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            self.view?.navigationController?.present(vc, animated: true)
        }
    }
}
