//
//  SendMoneySuccessRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneySuccessRouter {

    enum Route {
        case moveToHome
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneySuccessViewController {
        let viewController = SendMoneySuccessViewController.instantiate(fromAppStoryboard: .SendMoneySuccess)
        let presenter = SendMoneySuccessPresenter()
        let router = SendMoneySuccessRouter()
        let interactor = SendMoneySuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendMoneySuccessRouter: SendMoneySuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .moveToHome:
            self.view?.dismiss(animated: true, completion: {
            })
        }
    }
}
