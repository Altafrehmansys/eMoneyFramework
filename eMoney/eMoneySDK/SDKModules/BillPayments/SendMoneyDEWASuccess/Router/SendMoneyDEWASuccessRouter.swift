//
//  SendMoneyDEWASuccessRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyDEWASuccessRouter {

    enum Route {
        case moveToHome
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneyDEWASuccessViewController {
        let viewController = SendMoneyDEWASuccessViewController.instantiate(fromAppStoryboard: .SendMoneyDEWASuccess)
        let presenter = SendMoneyDEWASuccessPresenter()
        let router = SendMoneyDEWASuccessRouter()
        let interactor = SendMoneyDEWASuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendMoneyDEWASuccessRouter: SendMoneyDEWASuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .moveToHome:
            self.view?.dismiss(animated: true, completion: {
            })
        }
    }
}
