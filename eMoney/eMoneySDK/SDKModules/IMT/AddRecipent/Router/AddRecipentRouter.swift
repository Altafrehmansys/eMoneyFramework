//
//  AddRecipentRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class AddRecipentRouter {

    enum Route {
        case summary
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddRecipentViewController {
        let viewController = AddRecipentViewController.instantiate(fromAppStoryboard: .AddRecipent)
        let router = AddRecipentRouter()
        let interactor = AddRecipentInteractor()
        let presenter = AddRecipentPresenter()
    
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddRecipentRouter: AddRecipentRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .summary:
            let vc = SummaryRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
