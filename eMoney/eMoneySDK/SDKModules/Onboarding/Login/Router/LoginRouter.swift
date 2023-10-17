//
//  LoginRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit

class LoginRouter {

    enum Route {
        case navigateToForgotPin
        case home
        case otp
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> LoginViewController {
        let viewController = LoginViewController.instantiate(fromAppStoryboard: .Login)
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let interactor = LoginInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension LoginRouter: LoginRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToForgotPin:
            let vc = VerifyMobileNumberRouter.setupModule()
            vc.userJourneyEnum = .forgotPin
            view?.navigationController?.pushViewController(vc, animated: true)
        case .home:
            let vc = CustomTabbarViewController()
            CommonMethods.setRootViewControllerWithoutNavigation(viewController: vc)
            
        case .otp:
            let vc = VerifyMobileNumberRouter.setupModule()
            vc.msisdn = UserDefaultHelper.msisdn ?? ""
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
