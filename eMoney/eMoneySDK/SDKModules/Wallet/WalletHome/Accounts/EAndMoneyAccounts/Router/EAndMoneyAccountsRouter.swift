//
//  EAndMoneyAccountsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation
import UIKit

class EAndMoneyAccountsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EAndMoneyAccountsViewController {
        let viewController = EAndMoneyAccountsViewController.instantiate(fromAppStoryboard: .EAndMoneyAccounts)
        let presenter = EAndMoneyAccountsPresenter()
        let router = EAndMoneyAccountsRouter()
        let interactor = EAndMoneyAccountsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EAndMoneyAccountsRouter: EAndMoneyAccountsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .tempCase:
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
