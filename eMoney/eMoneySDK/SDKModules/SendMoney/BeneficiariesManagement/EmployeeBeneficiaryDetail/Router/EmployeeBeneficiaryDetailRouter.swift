//
//  EmployeeBeneficiaryDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation
import UIKit

class EmployeeBeneficiaryDetailRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EmployeeBeneficiaryDetailViewController {
        let viewController = EmployeeBeneficiaryDetailViewController.instantiate(fromAppStoryboard: .EmployeeBeneficiaryDetail)
        let presenter = EmployeeBeneficiaryDetailPresenter()
        let router = EmployeeBeneficiaryDetailRouter()
        let interactor = EmployeeBeneficiaryDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EmployeeBeneficiaryDetailRouter: EmployeeBeneficiaryDetailRouterProtocol {
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
