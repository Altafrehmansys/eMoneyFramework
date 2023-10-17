//
//  ThankyouRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/05/2023.
//  
//

import Foundation
import UIKit

class ThankyouRouter {

    enum Route {
        case navigateToEnterEmail
        case home
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ThankyouViewController {
        let viewController = ThankyouViewController.instantiate(fromAppStoryboard: .Thankyou)
        let presenter = ThankyouPresenter()
        let router = ThankyouRouter()
        let interactor = ThankyouInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ThankyouRouter: ThankyouRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToEnterEmail:
            let vc = RegisterEmailRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .home:
            let vc = CustomTabbarViewController()
            CommonMethods.setRootViewControllerWithoutNavigation(viewController: vc)
        case .tempCaseWithValue(let value):
            break
        }
    }
}
