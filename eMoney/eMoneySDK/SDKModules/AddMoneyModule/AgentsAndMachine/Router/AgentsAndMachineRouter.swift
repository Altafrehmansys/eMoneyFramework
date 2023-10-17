//
//  AgentsAndMachineRouter.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation
import UIKit

class AgentsAndMachineRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?
    
    struct Input {
        var getLocationNearByType: String
    }
    

    // MARK: Static methods

    static func setupModule(getLocationNearByType: String) -> AgentsAndMachineViewController {
        let viewController = AgentsAndMachineViewController.instantiate(fromAppStoryboard: .AgentsAndMachine)
        let presenter = AgentsAndMachinePresenter()
        let router = AgentsAndMachineRouter()
        let interactor = AgentsAndMachineInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.getLocationNearByType = getLocationNearByType

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AgentsAndMachineRouter: AgentsAndMachineRouterProtocol {
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
