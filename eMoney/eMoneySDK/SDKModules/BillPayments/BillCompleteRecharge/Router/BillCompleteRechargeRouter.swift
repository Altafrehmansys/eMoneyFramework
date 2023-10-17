//
//  BillCompleteRechargeRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 31/05/2023.
//  
//

import Foundation
import UIKit

class BillCompleteRechargeRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(inputs:BillAccountDetailsParameters?) -> BillCompleteRechargeViewController {
        let viewController = BillCompleteRechargeViewController()
        let presenter = BillCompleteRechargePresenter()
        presenter.inputs = inputs
        let router = BillCompleteRechargeRouter()
        let interactor = BillCompleteRechargeInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillCompleteRechargeRouter: BillCompleteRechargeRouterProtocol {
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
