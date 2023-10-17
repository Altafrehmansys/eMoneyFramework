//
//  AddNewVehicleRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//  
//

import Foundation
import UIKit

class AddNewVehicleRouter {

    enum Route {
        case back
    }
    
    struct RouterInput {
        var dataSource: [StandardCellModel]
        var actionButtons: [BaseButton]? = nil
    }
    
    // MARK: Properties
    weak var view: UIViewController?


    // MARK: Static methods

    static func setupModule(input: RouterInput? = nil) -> AddNewVehicleViewController {
        let viewController = AddNewVehicleViewController.instantiate(fromAppStoryboard: .AddNewVehicle)
        let presenter = AddNewVehiclePresenter()
        let router = AddNewVehicleRouter()
        let interactor = AddNewVehicleInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.dataSource = input?.dataSource
        presenter.actions = input?.actionButtons

        router.view = viewController

        interactor.output = presenter as! any AddNewVehicleInteractorOutputProtocol

        return viewController
    }
    
    
}

extension AddNewVehicleRouter: AddNewVehicleRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.dismiss(animated: true)
        }
    }
}
