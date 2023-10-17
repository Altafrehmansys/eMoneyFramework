//
//  DownloadAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation
import UIKit

class DownloadAccountDetailsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DownloadAccountDetailsViewController {
        let viewController = DownloadAccountDetailsViewController()
        let presenter = DownloadAccountDetailsPresenter()
        let router = DownloadAccountDetailsRouter()
        let interactor = DownloadAccountDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DownloadAccountDetailsRouter: DownloadAccountDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .tempCase:
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
