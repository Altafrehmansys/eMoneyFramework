//
//  IMTSelectTransferMethodRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class IMTSelectTransferMethodRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> IMTSelectTransferMethodViewController {
        let viewController = IMTSelectTransferMethodViewController.instantiate(fromAppStoryboard: .IMTSelectTransferMethod)
        let presenter = IMTSelectTransferMethodPresenter()
        let router = IMTSelectTransferMethodRouter()
        let interactor = IMTSelectTransferMethodInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension IMTSelectTransferMethodRouter: IMTSelectTransferMethodRouterProtocol {
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
