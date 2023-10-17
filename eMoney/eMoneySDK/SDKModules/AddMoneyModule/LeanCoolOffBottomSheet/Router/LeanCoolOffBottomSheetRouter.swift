//
//  LeanCoolOffBottomSheetRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 31/07/2023.
//  
//

import Foundation
import UIKit

class LeanCoolOffBottomSheetRouter {

    enum Route {
        case dismiss
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(coolDownTime: Int) -> LeanCoolOffBottomSheetViewController {
        let viewController = LeanCoolOffBottomSheetViewController.instantiate(fromAppStoryboard: .LeanCoolOffBottomSheet)
        let presenter = LeanCoolOffBottomSheetPresenter()
        let router = LeanCoolOffBottomSheetRouter()
        let interactor = LeanCoolOffBottomSheetInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.coolDownTime = coolDownTime

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension LeanCoolOffBottomSheetRouter: LeanCoolOffBottomSheetRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .dismiss:
            view?.dismiss(animated: true)
        }
    }
}
