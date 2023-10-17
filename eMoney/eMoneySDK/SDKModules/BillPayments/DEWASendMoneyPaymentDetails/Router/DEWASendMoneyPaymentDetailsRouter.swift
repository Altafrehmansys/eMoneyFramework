//
//  DEWASendMoneyPaymentDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation
import UIKit

class DEWASendMoneyPaymentDetailsRouter {

    enum Route {
        case moveToSendMoneySuccess
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DEWASendMoneyPaymentDetailsViewController {
        let viewController = DEWASendMoneyPaymentDetailsViewController.instantiate(fromAppStoryboard: .DEWASendMoneyPaymentDetails)
        let presenter = DEWASendMoneyPaymentDetailsPresenter()
        let router = DEWASendMoneyPaymentDetailsRouter()
        let interactor = DEWASendMoneyPaymentDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DEWASendMoneyPaymentDetailsRouter: DEWASendMoneyPaymentDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .moveToSendMoneySuccess:
            let vc = SendMoneyDEWASuccessRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
        }
    }
}

