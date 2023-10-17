//
//  AddBillsEnterAmountRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation
import UIKit

class AddBillsEnterAmountRouter {

    enum Route {
        case billCheckout(input:BillAccountDetailsParameters)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input:BillAccountDetailsParameters) -> AddBillsEnterAmountViewController {
        let viewController = AddBillsEnterAmountViewController.instantiate(fromAppStoryboard: .AddBillsEnterAmount)
        let presenter = AddBillsEnterAmountPresenter()
        let router = AddBillsEnterAmountRouter()
        let interactor = AddBillsEnterAmountInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.inPutParameters = input
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension AddBillsEnterAmountRouter: AddBillsEnterAmountRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .billCheckout(let input):
            let vc = BillPaymentCheckoutRouter.setupModule(input: input)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
