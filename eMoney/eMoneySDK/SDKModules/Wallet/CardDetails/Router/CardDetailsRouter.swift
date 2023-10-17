//
//  CardDetailsRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 10/07/2023.
//  
//

import Foundation
import UIKit

class CardDetailsRouter {

    enum Route {
        case manageCards
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> CardDetailsViewController {
        let viewController = CardDetailsViewController.instantiate(fromAppStoryboard: .CardDetails)
        let presenter = CardDetailsPresenter()
        let router = CardDetailsRouter()
        let interactor = CardDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension CardDetailsRouter: CardDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .manageCards:
            let vc = ManageCardRouter.setupModule()
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
