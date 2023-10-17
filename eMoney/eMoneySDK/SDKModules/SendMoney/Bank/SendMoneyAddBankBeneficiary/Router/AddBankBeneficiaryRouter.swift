//
//  AddBankBeneficiaryRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation
import UIKit

class AddBankBeneficiaryRouter {

    enum Route {
        case addNewBeneficiary
        case addedBeneficiaryDetails
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddBankBeneficiaryViewController {
        let viewController = AddBankBeneficiaryViewController.instantiate(fromAppStoryboard: .AddBankBeneficiary)
        let presenter = AddBankBeneficiaryPresenter()
        let router = AddBankBeneficiaryRouter()
        let interactor = AddBankBeneficiaryInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddBankBeneficiaryRouter: AddBankBeneficiaryRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .addNewBeneficiary:
            let vc = SendMoneyToBankAccountRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .addedBeneficiaryDetails:
            break
        }
    }
}
