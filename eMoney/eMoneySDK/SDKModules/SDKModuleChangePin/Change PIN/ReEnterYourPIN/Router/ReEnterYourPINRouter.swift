//
//  ReEnterYourPINRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class ReEnterYourPINRouter {

    enum Route {
        case successPinChange
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ReEnterYourPINViewController {
        let viewController = ReEnterYourPINViewController.instantiate(fromAppStoryboard: .ReEnterYourPIN)
        let presenter = ReEnterYourPINPresenter()
        let router = ReEnterYourPINRouter()
        let interactor = ReEnterYourPINInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ReEnterYourPINRouter: ReEnterYourPINRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .successPinChange:
            let vc = PinSuccessfulRouter.setupModule()
            view?.dismiss(animated: true, completion: {
                SDKNavigationStack.shared.baseViewController?.present(vc, animated: true)
            })
//            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
