//
//  MobileBeneficiaryDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation
import UIKit

class MobileBeneficiaryDetailRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MobileBeneficiaryDetailViewController {
        let viewController = MobileBeneficiaryDetailViewController.instantiate(fromAppStoryboard: .MobileBeneficiaryDetail)
        let presenter = MobileBeneficiaryDetailPresenter()
        let router = MobileBeneficiaryDetailRouter()
        let interactor = MobileBeneficiaryDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MobileBeneficiaryDetailRouter: MobileBeneficiaryDetailRouterProtocol {
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
