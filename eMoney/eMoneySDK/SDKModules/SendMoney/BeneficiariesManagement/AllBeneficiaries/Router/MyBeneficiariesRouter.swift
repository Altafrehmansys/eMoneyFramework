//
//  MyBeneficiariesRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/05/2023.
//  
//

import Foundation
import UIKit

class MyBeneficiariesRouter {

    enum Route {
        case bankBeneficiary
        case mobileBeneficiary
        case employeeBeneficiary
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MyBeneficiariesViewController {
        let viewController = MyBeneficiariesViewController.instantiate(fromAppStoryboard: .MyBeneficiaries)
        let presenter = MyBeneficiariesPresenter()
        let router = MyBeneficiariesRouter()
        let interactor = MyBeneficiariesInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MyBeneficiariesRouter: MyBeneficiariesRouterProtocol {
    // Implement Routing methods
   // BankBeneficiaryDetailRouter
    func go(to route: Route) {
        switch route {
        case .bankBeneficiary:
            let vc = BankBeneficiaryDetailRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .mobileBeneficiary:
            let vc = MobileBeneficiaryDetailRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .employeeBeneficiary:
            let vc = EmployeeBeneficiaryDetailRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
