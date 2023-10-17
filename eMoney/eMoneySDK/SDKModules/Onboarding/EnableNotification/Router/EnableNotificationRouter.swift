//
//  EnableNotificationRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation
import UIKit

class EnableNotificationRouter {

    enum Route {
        case routeToCardSelect
        case routeToKickStart
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EnableNotificationViewController {
        let viewController = EnableNotificationViewController.instantiate(fromAppStoryboard: .EnableNotification)
        let presenter = EnableNotificationPresenter()
        let router = EnableNotificationRouter()
        let interactor = EnableNotificationInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EnableNotificationRouter: EnableNotificationRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .routeToCardSelect:
            let vc = SelectCardRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .routeToKickStart:
            let vc = KickstartSuccessRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
