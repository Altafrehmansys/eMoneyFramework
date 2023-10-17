//
//  UpdateDEWAAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation
import UIKit

class UpdateDEWAAccountDetailsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> UpdateDEWAAccountDetailsViewController {
        let viewController = UpdateDEWAAccountDetailsViewController()
        let presenter = UpdateDEWAAccountDetailsPresenter()
        let router = UpdateDEWAAccountDetailsRouter()
        let interactor = UpdateDEWAAccountDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension UpdateDEWAAccountDetailsRouter: UpdateDEWAAccountDetailsRouterProtocol {
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
