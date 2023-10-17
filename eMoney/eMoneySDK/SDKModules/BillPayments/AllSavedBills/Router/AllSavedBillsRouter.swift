//
//  AllSavedBillsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation
import UIKit

class AllSavedBillsRouter {

    enum Route {
        case billManagement
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(allBills:[ListItems]) -> AllSavedBillsViewController {
        let viewController = AllSavedBillsViewController.instantiate(fromAppStoryboard: .AllSavedBills)
        let presenter = AllSavedBillsPresenter()
        let router = AllSavedBillsRouter()
        let interactor = AllSavedBillsInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.allBills = allBills
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension AllSavedBillsRouter: AllSavedBillsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .billManagement:
            let vc = BillManagementRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
