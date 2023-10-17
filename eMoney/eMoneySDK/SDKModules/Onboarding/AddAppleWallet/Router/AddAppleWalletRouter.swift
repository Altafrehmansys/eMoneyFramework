//
//  AddAppleWalletRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 27/04/2023.
//  
//

import Foundation
import UIKit

class AddAppleWalletRouter {

    enum Route {
        case navigateToWelcome
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddAppleWalletViewController {
        let viewController = AddAppleWalletViewController.instantiate(fromAppStoryboard: .AddAppleWallet)
        let presenter = AddAppleWalletPresenter()
        let router = AddAppleWalletRouter()
        let interactor = AddAppleWalletInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddAppleWalletRouter: AddAppleWalletRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToWelcome:
            if GlobalData.shared.registerAsAMLFailed {
                let vc = ThankyouRouter.setupModule()
                vc.screenTypeEnum = .amlVerification
                view?.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = KickstartSuccessRouter.setupModule()
                view?.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case .tempCaseWithValue(_):
            break
        }
    }
}
