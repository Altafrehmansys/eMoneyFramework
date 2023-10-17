//
//  TransferStatusRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class TransferStatusRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> TransferStatusViewController {
        let viewController = TransferStatusViewController.instantiate(fromAppStoryboard: .TransferStatus)
        let presenter = TransferStatusPresenter()
        let router = TransferStatusRouter()
        let interactor = TransferStatusInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TransferStatusRouter: TransferStatusRouterProtocol {
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
