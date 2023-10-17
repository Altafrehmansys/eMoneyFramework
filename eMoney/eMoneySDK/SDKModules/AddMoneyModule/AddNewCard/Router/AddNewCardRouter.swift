//
//  AddNewCardRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 05/05/2023.
//  
//

import Foundation
import UIKit

class AddNewCardRouter {

    enum Route {
        case scanCard
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddNewCardViewController {
        let viewController = AddNewCardViewController.instantiate(fromAppStoryboard: .AddNewCard)
        let presenter = AddNewCardPresenter()
        let router = AddNewCardRouter()
        let interactor = AddNewCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

// MARK: - Class Methods
extension AddNewCardRouter: AddNewCardRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .scanCard:
            let vc = AddMoneyScanCardRouter.setupModule(with: view as! AddNewCardViewController)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
