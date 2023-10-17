//
//  SelectProviderViewRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation
import UIKit

class SelectProviderViewRouter {
    
    enum Route {
        case dimiss
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(countryISO: String, delegate: SelectProviderViewDelegate?) -> SelectProviderViewController {
        let viewController = SelectProviderViewController()
        let presenter = SelectProviderViewPresenter(countryISO: countryISO)
        presenter.delegate = delegate
        let router = SelectProviderViewRouter()
        let interactor = SelectProviderViewInteractor()
        interactor.service = NetworkProvidersService()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension SelectProviderViewRouter: SelectProviderViewRouterProtocol {
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
