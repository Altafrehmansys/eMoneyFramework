//
//  OtpPopupRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation
import UIKit

class OtpForgotPinPopupRouter {

    enum Route {
        case newPin
        case failedOtp(model:VerifyMobileNumberResponseModel)
        case dismiss
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods
    
    static func setupModule() -> OtpForgotPinPopupViewController {
        let viewController = OtpForgotPinPopupViewController.instantiate(fromAppStoryboard: .OtpForgotPinPopup)
        let presenter = OtpForgotPinPopupPresenter()
        let router = OtpForgotPinPopupRouter()
        let interactor = OtpForgotPinPopupInteractor()

        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension OtpForgotPinPopupRouter: OtpForgotPinPopupRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .newPin:
            let vc = RegisterPinRouter.setupModule()
            vc.userJourneyEnum = .forgotPin
            view?.navigationController?.pushViewController(vc, animated: true)
        case .failedOtp(let model):
            let vc = FailedOtpRouter.setupModule()
            vc.responseObj = model
            view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .dismiss:
            view?.dismiss(animated: true, completion: nil)
        }
    }
}
