//
//  FineDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class FineDetailRouter {

    enum Route {
        case successFullScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> FineDetailViewController {
        let viewController = FineDetailViewController.instantiate(fromAppStoryboard: .FineDetail)
        let presenter = FineDetailPresenter()
        let router = FineDetailRouter()
        let interactor = FineDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension FineDetailRouter: FineDetailRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .successFullScreen:
            let vc = MobileBillPaymentSuccessfullRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
