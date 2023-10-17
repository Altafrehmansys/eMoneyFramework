//
//  AddMobileBillPaymentDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation
import UIKit

class AddMobileBillPaymentDetailRouter {

    enum Route {
        case successScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddMobileBillPaymentDetailViewController {
        let viewController = AddMobileBillPaymentDetailViewController.instantiate(fromAppStoryboard: .AddMobileBillPaymentDetail)
        let presenter = AddMobileBillPaymentDetailPresenter()
        let router = AddMobileBillPaymentDetailRouter()
        let interactor = AddMobileBillPaymentDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMobileBillPaymentDetailRouter: AddMobileBillPaymentDetailRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .successScreen:
            let vc = MobileBillPaymentSuccessfullRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
