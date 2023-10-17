//
//  SendMoneyEnterAmountRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyEnterAmountRouter {

    enum Route {
        case navigateSendMoneyPaymentDetails
      
    }
   
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneyEnterAmountViewController {
        let viewController = SendMoneyEnterAmountViewController.instantiate(fromAppStoryboard: .SendMoneyEnterAmount)
        let presenter = SendMoneyEnterAmountPresenter()
        let router = SendMoneyEnterAmountRouter()
        let interactor = SendMoneyEnterAmountInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendMoneyEnterAmountRouter: SendMoneyEnterAmountRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateSendMoneyPaymentDetails:
            let vc = SendMoneyPaymentDetailsRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
