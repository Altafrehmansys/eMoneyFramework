//
//  SelectCardRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation
import UIKit

class SelectCardRouter {

    enum Route {
        case navigateToWallet(cardType : SelectCardColor)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SelectCardViewController {
        let viewController = SelectCardViewController.instantiate(fromAppStoryboard: .SelectCard)
        let presenter = SelectCardPresenter()
        let router = SelectCardRouter()
        let interactor = SelectCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SelectCardRouter: SelectCardRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToWallet(let cardType):
            let vc = AddAppleWalletRouter.setupModule()
            vc.cardColorEnum = cardType
            view?.navigationController?.pushViewController(vc, animated: true)
      
        }
    }
}
