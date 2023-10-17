//
//  DeliveryDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation
import UIKit

class DeliveryDetailsRouter {

    enum Route {
        case addAddress
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DeliveryDetailsViewController {
        let viewController = DeliveryDetailsViewController()
        let presenter = DeliveryDetailsPresenter()
        let router = DeliveryDetailsRouter()
        let interactor = DeliveryDetailsInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension DeliveryDetailsRouter: DeliveryDetailsRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .addAddress:
            let vc = DeliveryDetailsAddAdressRouter.setupModule()
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
