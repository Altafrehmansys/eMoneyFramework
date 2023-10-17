//
//  SelectPlanRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 25/05/2023.
//  
//

import Foundation
import UIKit

class SelectPlanRouter {

    enum Route {
        case billPaymentCheckout(_ input: BillAccountDetailsParameters)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input:BillAccountDetailsParameters) -> SelectPlanViewController {
        let viewController = SelectPlanViewController.instantiate(fromAppStoryboard: .SelectPlan)
        let presenter = SelectPlanPresenter()
        let router = SelectPlanRouter()
        let interactor = SelectPlanInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.input = input

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SelectPlanRouter: SelectPlanRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .billPaymentCheckout(let input):
            let vc = BillPaymentCheckoutRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
