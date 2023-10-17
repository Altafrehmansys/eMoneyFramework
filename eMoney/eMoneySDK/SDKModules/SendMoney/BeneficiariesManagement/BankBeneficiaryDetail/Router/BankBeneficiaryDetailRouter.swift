//
//  BankBeneficiaryDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//  
//

import Foundation
import UIKit

class BankBeneficiaryDetailRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BankBeneficiaryDetailViewController {
        let viewController = BankBeneficiaryDetailViewController.instantiate(fromAppStoryboard: .BankBeneficiaryDetail)
        let presenter = BankBeneficiaryDetailPresenter()
        let router = BankBeneficiaryDetailRouter()
        let interactor = BankBeneficiaryDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BankBeneficiaryDetailRouter: BankBeneficiaryDetailRouterProtocol {
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
