//
//  DeliveryDetailsAddAdressRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation
import UIKit

class DeliveryDetailsAddAdressRouter {

    enum Route {
        case confirmPay
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DeliveryDetailsAddAdressViewController {
        let viewController = DeliveryDetailsAddAdressViewController()
        let presenter = DeliveryDetailsAddAdressPresenter()
        let router = DeliveryDetailsAddAdressRouter()
        let interactor = DeliveryDetailsAddAdressInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DeliveryDetailsAddAdressRouter: DeliveryDetailsAddAdressRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .confirmPay:
            break
//            let data = BillAccountDetailsParameters(billType: .homeDu, transactionId: "", accountNumber: "",billMin:"1",billMax:"5000")
//            let vc = WalletCheckoutRouter.setupModule(input: data)
//            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
