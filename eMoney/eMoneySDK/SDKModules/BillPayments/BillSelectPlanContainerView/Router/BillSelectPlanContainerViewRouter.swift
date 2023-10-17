//
//  BillSelectPlanContainerViewRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//  
//

import Foundation
import UIKit

class BillSelectPlanContainerViewRouter {

    enum Route {
        case sendMoney(input: BillAccountDetailsParameters)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: BillAccountDetailsParameters) -> BillSelectPlanContainerViewController {
        let viewController = BillSelectPlanContainerViewController()
        let presenter = BillSelectPlanContainerViewPresenter()
        let router = BillSelectPlanContainerViewRouter()
        let interactor = BillSelectPlanContainerViewInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.input = input
        presenter.router = router
        presenter.interactor = interactor
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension BillSelectPlanContainerViewRouter: BillSelectPlanContainerViewRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .sendMoney(data):
            navigateToSendMoney(data: data)
        }
    }
    
    private func navigateToSendMoney(data: BillAccountDetailsParameters) {
        let vc = BillPaymentCheckoutRouter.setupModule(input: data)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
