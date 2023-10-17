//
//  ManageSavedCardRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/05/2023.
//  
//

import Foundation
import UIKit

class ManageSavedCardRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ManageSavedCardViewController {
        let viewController = ManageSavedCardViewController.instantiate(fromAppStoryboard: .ManageSavedCard)
        let presenter = ManageSavedCardPresenter()
        let router = ManageSavedCardRouter()
        let interactor = ManageSavedCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ManageSavedCardRouter: ManageSavedCardRouterProtocol {
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
