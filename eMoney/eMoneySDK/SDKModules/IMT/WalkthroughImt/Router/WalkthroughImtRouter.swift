//
//  WalkthroughImtRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation
import UIKit

class WalkthroughImtRouter {

    enum Route {
        case startSending
        case watchTutorial
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> WalkthroughImtViewController {
        let viewController = WalkthroughImtViewController.instantiate(fromAppStoryboard: .WalkthroughImt)
        let presenter = WalkthroughImtPresenter()
        let router = WalkthroughImtRouter()
        let interactor = WalkthroughImtInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension WalkthroughImtRouter: WalkthroughImtRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .startSending:
            let vc = SendAbroadRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .watchTutorial:
            break
        }
    }
}
