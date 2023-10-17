//
//  ForgotPasswordRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 15/06/2023.
//  
//

import Foundation
import UIKit

class ForgotPasswordRouter {

    enum Route {
        case backToLogin
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ForgotPasswordViewController {
        let viewController = ForgotPasswordViewController.instantiate(fromAppStoryboard: .ForgotPassword)
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()
        let interactor = ForgotPasswordInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ForgotPasswordRouter: ForgotPasswordRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .backToLogin:
            let vc = LoginRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        }
    }
}
