//
//  DEWATransferDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 06/06/2023.
//  
//

import Foundation
import UIKit

class DEWATransferDetailsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DEWATransferDetailsViewController {
        let viewController = DEWATransferDetailsViewController()
        let presenter = DEWATransferDetailsPresenter()
        let router = DEWATransferDetailsRouter()
        let interactor = DEWATransferDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DEWATransferDetailsRouter: DEWATransferDetailsRouterProtocol {
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
