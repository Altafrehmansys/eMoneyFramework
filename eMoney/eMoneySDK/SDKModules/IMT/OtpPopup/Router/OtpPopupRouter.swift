//
//  OtpPopupRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation
import UIKit

class OtpPopupRouter {

    enum Route {
        case failedOtp(model:VerifyMobileNumberResponseModel)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods
    
    struct Input {
        var msisdn: String
        var addingText: String
        var amount: String
        var toTitle: String
        var flowName: FlowNames? = nil
    }
    
    static func setupModule(input: Input) -> OtpPopupViewController {
        let viewController = OtpPopupViewController.instantiate(fromAppStoryboard: .OtpPopup)
        let presenter = OtpPopupPresenter()
        let router = OtpPopupRouter()
        let interactor = OtpPopupInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.msisdn = input.msisdn
        presenter.addingText = input.addingText
        presenter.amount = input.amount
        presenter.toTitle = input.toTitle
        presenter.flowName = input.flowName

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension OtpPopupRouter: OtpPopupRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .failedOtp(let model):
            let vc = FailedOtpRouter.setupModule()
            vc.responseObj = model
            view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
}
