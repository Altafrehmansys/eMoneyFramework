//
//  AddBeneficiaryRouter.swift
//  e&money
//
//  Created by Qamar Iqbal on 15/06/2023.
//  
//

import Foundation
import UIKit

class AddBeneficiaryRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddBeneficiaryViewController {
        let viewController = AddBeneficiaryViewController.instantiate(fromAppStoryboard: .AddBeneficiary)
        let presenter = AddBeneficiaryPresenter()
        let router = AddBeneficiaryRouter()
        let interactor = AddBeneficiaryInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddBeneficiaryRouter: AddBeneficiaryRouterProtocol {
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
