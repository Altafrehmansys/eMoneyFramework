//
//  CardAccountLimitsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//  
//

import Foundation
import UIKit

class CardAccountLimitsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> CardAccountLimitsViewController {
        let viewController = CardAccountLimitsViewController.instantiate(fromAppStoryboard: .CardAccountLimits)
        let presenter = CardAccountLimitsPresenter()
        let router = CardAccountLimitsRouter()
        let interactor = CardAccountLimitsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension CardAccountLimitsRouter: CardAccountLimitsRouterProtocol {
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
