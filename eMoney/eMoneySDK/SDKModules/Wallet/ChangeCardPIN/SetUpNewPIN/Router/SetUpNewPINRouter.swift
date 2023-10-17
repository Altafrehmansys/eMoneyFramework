//
//  SetUpNewPINRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation
import UIKit

class SetUpNewPINRouter {

    enum Route {
        case navigateToConfirmCardPIN
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SetUpNewPINViewController {
        let viewController = SetUpNewPINViewController.instantiate(fromAppStoryboard: .SetUpNewPIN)
        let presenter = SetUpNewPINPresenter()
        let router = SetUpNewPINRouter()
        let interactor = SetUpNewPINInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SetUpNewPINRouter: SetUpNewPINRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToConfirmCardPIN:
            let vc = ReEnterYourPINRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
