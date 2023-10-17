//
//  CancelCardRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation
import UIKit

class CancelCardRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> CancelCardViewController {
        let viewController = CancelCardViewController.instantiate(fromAppStoryboard: .CancelCard)
        let presenter = CancelCardPresenter()
        let router = CancelCardRouter()
        let interactor = CancelCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension CancelCardRouter: CancelCardRouterProtocol {
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
