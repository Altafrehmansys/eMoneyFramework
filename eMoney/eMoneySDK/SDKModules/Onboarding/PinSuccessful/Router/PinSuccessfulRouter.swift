//
//  PinSuccessfulRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation
import UIKit

class PinSuccessfulRouter {

    enum Route {
        case loginView
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> PinSuccessfulViewController {
        let viewController = PinSuccessfulViewController.instantiate(fromAppStoryboard: .PinSuccessful)
        let presenter = PinSuccessfulPresenter()
        let router = PinSuccessfulRouter()
        let interactor = PinSuccessfulInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension PinSuccessfulRouter: PinSuccessfulRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .loginView:
            view?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
