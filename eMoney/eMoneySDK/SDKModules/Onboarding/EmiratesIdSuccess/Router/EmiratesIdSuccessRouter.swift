//
//  PinSuccessfulRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation
import UIKit

class EmiratesIdSuccessRouter {

    enum Route {
        case loginView
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EmiratesIdSuccessViewController {
        let viewController = EmiratesIdSuccessViewController.instantiate(fromAppStoryboard: .EmiratesIdSuccess)
        let presenter = EmiratesIdSuccessPresenter()
        let router = EmiratesIdSuccessRouter()
        let interactor = EmiratesIdSuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EmiratesIdSuccessRouter: EmiratesIdSuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .loginView:
            SDKColors.shared.onSuccess?("")
            view?.dismiss(animated: true)
//            view?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
