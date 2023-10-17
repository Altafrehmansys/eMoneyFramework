//
//  MobileBillPaymentSuccessfullRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation
import UIKit

class MobileBillPaymentSuccessfullRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MobileBillPaymentSuccessfullViewController {
        let viewController = MobileBillPaymentSuccessfullViewController.instantiate(fromAppStoryboard: .MobileBillPaymentSuccessfull)
        let presenter = MobileBillPaymentSuccessfullPresenter()
        let router = MobileBillPaymentSuccessfullRouter()
        let interactor = MobileBillPaymentSuccessfullInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MobileBillPaymentSuccessfullRouter: MobileBillPaymentSuccessfullRouterProtocol {
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
