//
//  WalletCardSuccessRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation
import UIKit

class WalletCardSuccessRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> WalletCardSuccessViewController {
        let viewController = WalletCardSuccessViewController.instantiate(fromAppStoryboard: .WalletCardSuccess)
        let presenter = WalletCardSuccessPresenter()
        let router = WalletCardSuccessRouter()
        let interactor = WalletCardSuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension WalletCardSuccessRouter: WalletCardSuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .tempCase:
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
