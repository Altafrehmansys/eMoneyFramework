//
//  DueBillsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation
import UIKit

class DueBillsRouter {

    enum Route {
        case navigateToDueBillsDetail
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DueBillsViewController {
        let viewController = DueBillsViewController.instantiate(fromAppStoryboard: .DueBills)
        let presenter = DueBillsPresenter()
        let router = DueBillsRouter()
        let interactor = DueBillsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DueBillsRouter: DueBillsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToDueBillsDetail:
            let vc = DueBillsDetailRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
