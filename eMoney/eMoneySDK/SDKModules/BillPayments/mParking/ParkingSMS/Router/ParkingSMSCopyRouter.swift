//
//  ParkingSMSCopyRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation
import UIKit

class ParkingSMSCopyRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(_ model:ParkingSMSCopyResponseModel) -> ParkingSMSCopyViewController {
        let viewController = ParkingSMSCopyViewController.instantiate(fromAppStoryboard: .ParkingSMSCopy)
        let presenter = ParkingSMSCopyPresenter()
        let router = ParkingSMSCopyRouter()
        let interactor = ParkingSMSCopyInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.model = model

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ParkingSMSCopyRouter: ParkingSMSCopyRouterProtocol {
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
