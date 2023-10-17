//
//  TermsConditionsRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit

class TermsConditionsRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> TermsConditionsViewController {
        let viewController = TermsConditionsViewController.instantiate(fromAppStoryboard: .TermsConditions)
        let presenter = TermsConditionsPresenter()
        let router = TermsConditionsRouter()
        let interactor = TermsConditionsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TermsConditionsRouter: TermsConditionsRouterProtocol {
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
