//
//  AccountDetailsRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 24/05/2023.
//  
//

import Foundation
import UIKit

class AccountDetailsRouter {

    enum Route {
        case selectPlan
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AccountDetailsViewController {
        let viewController = AccountDetailsViewController.instantiate(fromAppStoryboard: .AccountDetails)
        let presenter = AccountDetailsPresenter()
        let router = AccountDetailsRouter()
        let interactor = AccountDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AccountDetailsRouter: AccountDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
//        case .selectPlan(let input):
//            let vc = SelectPlanRouter.setupModule(input: <#BillAccountDetailsParameters#>)
//            view?.navigationController?.pushViewController(vc, animated: true)
        case .tempCase:
            break
        case .tempCaseWithValue(let value):
            break
        default:break
        }
    }
}
