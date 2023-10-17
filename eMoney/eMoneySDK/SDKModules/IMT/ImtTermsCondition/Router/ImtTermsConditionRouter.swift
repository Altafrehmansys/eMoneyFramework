//
//  ImtTermsConditionRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 02/06/2023.
//  
//

import Foundation
import UIKit

class ImtTermsConditionRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ImtTermsConditionViewController {
        let viewController = ImtTermsConditionViewController.instantiate(fromAppStoryboard: .ImtTermsCondition)
        let presenter = ImtTermsConditionPresenter()
        let router = ImtTermsConditionRouter()
        let interactor = ImtTermsConditionInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ImtTermsConditionRouter: ImtTermsConditionRouterProtocol {
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
