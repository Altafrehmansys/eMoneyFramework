//
//  KickstartSuccessRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/05/2023.
//  
//

import Foundation
import UIKit

class KickstartSuccessRouter {

    enum Route {
        case home
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> KickstartSuccessViewController {
        let viewController = KickstartSuccessViewController.instantiate(fromAppStoryboard: .KickstartSuccess)
        let presenter = KickstartSuccessPresenter()
        let router = KickstartSuccessRouter()
        let interactor = KickstartSuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension KickstartSuccessRouter: KickstartSuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .home:
//            let vc = CustomTabbarViewController()
//            CommonMethods.setRootViewControllerWithoutNavigation(viewController: vc)
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
