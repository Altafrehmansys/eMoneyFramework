//
//  BillDEWAEasypayNumberInfoRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAEasypayNumberInfoRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BillDEWAEasypayNumberInfoViewController {
        let viewController = BillDEWAEasypayNumberInfoViewController()
        let presenter = BillDEWAEasypayNumberInfoPresenter()
        let router = BillDEWAEasypayNumberInfoRouter()
        let interactor = BillDEWAEasypayNumberInfoInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillDEWAEasypayNumberInfoRouter: BillDEWAEasypayNumberInfoRouterProtocol {
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
