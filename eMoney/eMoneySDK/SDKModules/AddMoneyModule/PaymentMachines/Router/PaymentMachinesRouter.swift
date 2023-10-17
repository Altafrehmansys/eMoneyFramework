//
//  PaymentMachinesRouter.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//  
//

import Foundation
import UIKit

class PaymentMachinesRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    struct Input {
        var getLocationNearByType: String
    }
    
    // MARK: Properties

    weak var view: UIViewController?


    // MARK: Static methods

    static func setupModule(getLocationNearByType: String) -> PaymentMachinesViewController {
        let viewController = PaymentMachinesViewController.instantiate(fromAppStoryboard: .PaymentMachines)
        let presenter = PaymentMachinesPresenter()
        let router = PaymentMachinesRouter()
        let interactor = PaymentMachinesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.getLocationNearByType = getLocationNearByType

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension PaymentMachinesRouter: PaymentMachinesRouterProtocol {
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
