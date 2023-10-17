//
//  RegisterEmailRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation
import UIKit

class RegisterEmailRouter {

    enum Route {
        case registerPin
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> RegisterEmailViewController {
        let viewController = RegisterEmailViewController.instantiate(fromAppStoryboard: .RegisterEmail)
        let presenter = RegisterEmailPresenter()
        let router = RegisterEmailRouter()
        let interactor = RegisterEmailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension RegisterEmailRouter: RegisterEmailRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .registerPin:
            let vc = RegisterPinRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
