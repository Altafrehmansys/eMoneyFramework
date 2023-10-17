//
//  RegisterPinRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation
import UIKit

class RegisterPinRouter {

    enum Route {
        case navigateToReEnterPin(pin:String,flowType : UserJourneyFlow)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> RegisterPinViewController {
        let viewController = RegisterPinViewController.instantiate(fromAppStoryboard: .RegisterPin)
        let presenter = RegisterPinPresenter()
        let router = RegisterPinRouter()
        let interactor = RegisterPinInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
    static func setupModule(vc: RegisterPinViewController) -> RegisterPinViewController {
        let viewController = vc
        let presenter = RegisterPinPresenter()
        let router = RegisterPinRouter()
        let interactor = RegisterPinInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
    
}

extension RegisterPinRouter: RegisterPinRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToReEnterPin(let pin, let flowType):
            let vc = ReEnterPinRouter.setupModule()
            vc.pinPassword = pin
            vc.userJourneyEnum = flowType
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
