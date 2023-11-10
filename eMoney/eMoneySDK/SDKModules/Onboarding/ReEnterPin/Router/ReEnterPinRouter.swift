//
//  ReEnterPinRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation
import UIKit

class ReEnterPinRouter {

    enum Route {
        case navigateToNotificationScreen
        case backToLogin
        case navigateToSuccess
        case navigateForgotPinSuccess
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ReEnterPinViewController {
        let viewController = ReEnterPinViewController.instantiate(fromAppStoryboard: .ReEnterPin)
        let presenter = ReEnterPinPresenter()
        let router = ReEnterPinRouter()
        let interactor = ReEnterPinInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ReEnterPinRouter: ReEnterPinRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToNotificationScreen:
//            let vc = EnableNotificationRouter.setupModule()
//            view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .backToLogin :
            let vc = LoginRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        case .navigateToSuccess :
            let vc = ForgotPasswordRouter.setupModule()
            
            view?.dismiss(animated: true, completion: {
                SDKNavigationStack.shared.baseViewController?.present(vc, animated: true)
            })
//            let vc = ForgotPasswordRouter.setupModule()
//            view?.navigationController?.pushViewController(vc, animated: true)
        case .navigateForgotPinSuccess :
            let vc = PinSuccessfulRouter.setupModule()
            view?.dismiss(animated: true, completion: {
                SDKNavigationStack.shared.baseViewController?.present(vc, animated: true)
            })
//            view?.navigationController?.pushViewController(vc, animated: true)
        
        }
    }
}
