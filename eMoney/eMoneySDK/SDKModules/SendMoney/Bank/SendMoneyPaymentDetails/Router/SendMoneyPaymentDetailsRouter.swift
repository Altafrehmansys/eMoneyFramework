//
//  SendMoneyPaymentDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyPaymentDetailsRouter {

    enum Route {
        case moveToSendMoneySuccess
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneyPaymentDetailsViewController {
        let viewController = SendMoneyPaymentDetailsViewController.instantiate(fromAppStoryboard: .SendMoneyPaymentDetails)
        let presenter = SendMoneyPaymentDetailsPresenter()
        let router = SendMoneyPaymentDetailsRouter()
        let interactor = SendMoneyPaymentDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendMoneyPaymentDetailsRouter: SendMoneyPaymentDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .moveToSendMoneySuccess:
            let vc = SendMoneySuccessRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
            break
        }
    }
}

