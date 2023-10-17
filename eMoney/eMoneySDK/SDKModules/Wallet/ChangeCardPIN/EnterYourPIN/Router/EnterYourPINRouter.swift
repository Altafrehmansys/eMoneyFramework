//
//  EnterYourPINRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class EnterYourPINRouter {

    enum Route {
        case navigateToForgotPINScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EnterYourPINViewController {
        let viewController = EnterYourPINViewController.instantiate(fromAppStoryboard: .EnterYourPIN)
        let presenter = EnterYourPINPresenter()
        let router = EnterYourPINRouter()
        let interactor = EnterYourPINInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EnterYourPINRouter: EnterYourPINRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToForgotPINScreen:
            let vc = SetUpNewPINRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
