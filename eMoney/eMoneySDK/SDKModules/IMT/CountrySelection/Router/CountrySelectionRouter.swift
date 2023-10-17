//
//  CountrySelectionRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/05/2023.
//  
//

import Foundation
import UIKit

class CountrySelectionRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> CountrySelectionViewController {
        let viewController = CountrySelectionViewController.instantiate(fromAppStoryboard: .CountrySelection)
        let presenter = CountrySelectionPresenter()
        let router = CountrySelectionRouter()
        let interactor = CountrySelectionInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension CountrySelectionRouter: CountrySelectionRouterProtocol {
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
