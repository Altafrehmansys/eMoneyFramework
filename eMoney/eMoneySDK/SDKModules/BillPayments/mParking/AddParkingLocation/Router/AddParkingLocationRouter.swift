//
//  AddParkingLocationRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/06/2023.
//  
//

import Foundation
import UIKit

class AddParkingLocationRouter {

    enum Route {
        case presentParkingDetails(GenericBottomSheetRouter.RouterInput?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddParkingLocationViewController {
        let viewController = AddParkingLocationViewController.instantiate(fromAppStoryboard: .AddParkingLocation)
        let presenter = AddParkingLocationPresenter()
        let router = AddParkingLocationRouter()
        let interactor = AddParkingLocationInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddParkingLocationRouter: AddParkingLocationRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .presentParkingDetails(let input):
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            self.view?.navigationController?.present(vc, animated: true)
        }
    }
}
