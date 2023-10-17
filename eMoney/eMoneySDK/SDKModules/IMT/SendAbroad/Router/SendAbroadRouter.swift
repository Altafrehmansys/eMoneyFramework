//
//  SendAbroadRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation
import UIKit

class SendAbroadRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendAbroadViewController {
        let viewController = SendAbroadViewController.instantiate(fromAppStoryboard: .SendAbroad)
        let presenter = SendAbroadPresenter()
        let router = SendAbroadRouter()
        let interactor = SendAbroadInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendAbroadRouter: SendAbroadRouterProtocol {
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
