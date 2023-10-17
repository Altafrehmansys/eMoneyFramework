//
//  FailedOtpRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit

class FailedOtpRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> FailedOtpViewController {
        let viewController = FailedOtpViewController.instantiate(fromAppStoryboard: .FailedOtp)
        let presenter = FailedOtpPresenter()
        let router = FailedOtpRouter()
        let interactor = FailedOtpInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension FailedOtpRouter: FailedOtpRouterProtocol {
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
