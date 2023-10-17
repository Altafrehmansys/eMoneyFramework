//
//  WalkthroughIntroRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 14/04/2023.
//  
//

import Foundation
import UIKit

class WalkthroughIntroRouter {

    enum Route {
        case navigateToRegisterMobile
        case navigateToLoginMobile
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> WalkthroughIntroViewController {
        let viewController = WalkthroughIntroViewController.instantiate(fromAppStoryboard: .WalkthroughIntro)
        let presenter = WalkthroughIntroPresenter()
        let router = WalkthroughIntroRouter()
        let interactor = WalkthroughIntroInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension WalkthroughIntroRouter: WalkthroughIntroRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        print("route called")
        switch route {
        case .navigateToRegisterMobile:
            let vc = RegisterMobileNumberRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .navigateToLoginMobile:
            let vc = LoginNumberRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

