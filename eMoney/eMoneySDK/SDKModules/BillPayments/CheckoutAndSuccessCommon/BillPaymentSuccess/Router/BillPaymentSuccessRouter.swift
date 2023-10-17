//
//  BillPaymentSuccessRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation
import UIKit

class BillPaymentSuccessRouter {

    enum Route {
        case completeRecharge(input: BillAccountDetailsParameters?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(viewData: BillPaymentSuccessViewData?,input:BillAccountDetailsParameters?, _ datasource:[StandardCellModel] = [], hideAutoSave:Bool = false) -> BillPaymentSuccessViewController {
        let viewController = BillPaymentSuccessViewController.instantiate(fromAppStoryboard: .BillPaymentSuccess)
        let presenter = BillPaymentSuccessPresenter()
        let router = BillPaymentSuccessRouter()
        let interactor = BillPaymentSuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.datasource = datasource
        presenter.hideAutoSave = hideAutoSave
        presenter.viewData = viewData
        presenter.input = input
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillPaymentSuccessRouter: BillPaymentSuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .completeRecharge(input):
            let vc = BillCompleteRechargeRouter.setupModule(inputs: input)
            vc.modalPresentationStyle = .fullScreen
            self.view?.present(vc, animated: true)
        }
    }
}
