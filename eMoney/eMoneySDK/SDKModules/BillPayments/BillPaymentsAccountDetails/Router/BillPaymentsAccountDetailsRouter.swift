//
//  BillPaymentsAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//  
//

import Foundation
import UIKit

class BillPaymentsAccountDetailsRouter {

    enum Route {
        case selectPlan
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BillPaymentsAccountDetailsViewController {
        let viewController = BillPaymentsAccountDetailsViewController()
        let presenter = BillPaymentsAccountDetailsPresenter()
        let router = BillPaymentsAccountDetailsRouter()
        let interactor = BillPaymentsAccountDetailsInteractor()
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillPaymentsAccountDetailsRouter: BillPaymentsAccountDetailsRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
            case .selectPlan:
            break
           // let vc = BillSelectPlanContainerViewRouter.setupModule(input: <#BillAccountDetailsParameters#>)
           // self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
