//
//  SelectCountryRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//

import Foundation
import UIKit

class SelectCountryViewRouter {
    
    enum Route {
        case dimiss
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(delegate: SelectCountryViewDelegate?) -> SelectCountryViewController {
        let viewController = SelectCountryViewController()
        let presenter = SelectCountryViewPresenter()
        presenter.delegate = delegate
        let router = SelectCountryViewRouter()
        let interactor = SelectCountryViewInteractor()
        interactor.service = CountryService()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension SelectCountryViewRouter: SelectCountryViewRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .dimiss:
            dismissViewController()
        }
    }
    private func dismissViewController() {
        view?.dismiss(animated: true)
    }
}

