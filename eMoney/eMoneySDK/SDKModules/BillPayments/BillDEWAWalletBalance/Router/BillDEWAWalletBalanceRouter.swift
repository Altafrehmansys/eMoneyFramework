//
//  BillDEWAWalletBalanceRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAWalletBalanceRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BillDEWAWalletBalanceViewController {
        let viewController = BillDEWAWalletBalanceViewController()
        let presenter = BillDEWAWalletBalancePresenter()
        let router = BillDEWAWalletBalanceRouter()
        let interactor = BillDEWAWalletBalanceInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillDEWAWalletBalanceRouter: BillDEWAWalletBalanceRouterProtocol {
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
