//
//  LoginNumberRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/05/2023.
//  
//

import Foundation
import UIKit

class LoginNumberRouter {

    enum Route {
        case navigateToOtp(msisdn:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> LoginNumberViewController {
        let viewController = LoginNumberViewController.instantiate(fromAppStoryboard: .LoginNumber)
        let presenter = LoginNumberPresenter()
        let router = LoginNumberRouter()
        let interactor = LoginNumberInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension LoginNumberRouter: LoginNumberRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToOtp(let msisdn):
            let vc = VerifyMobileNumberRouter.setupModule()
            vc.isNumberChange = CommonMethods.checkIfNumberChange(msisd: msisdn)
            GlobalData.shared.msisdn = msisdn
            GlobalData.shared.lastNumberInput = msisdn
            vc.msisdn = msisdn
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
