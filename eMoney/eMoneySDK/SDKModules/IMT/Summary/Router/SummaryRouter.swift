//
//  SummaryRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SummaryRouter {

    enum Route {
        case senderDetails
        case FraudWarning
        case otpImt
        case successTransfer
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SummaryViewController {
        let viewController = SummaryViewController.instantiate(fromAppStoryboard: .Summary)
        let router = SummaryRouter()
        let interactor = SummaryInteractor()
        let presenter = SummaryPresenter()
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SummaryRouter: SummaryRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .senderDetails:
            let vc = SenderDetailRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            view?.present(vc, animated: true)
        case .FraudWarning:
            let vc = ImtTermsConditionRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            view?.present(vc, animated: true)
        case .otpImt:
            break
//            let vc = OtpPopupRouter.setupModule()
//            vc.modalPresentationStyle = .overCurrentContext
//            view?.present(vc, animated: true)
        case .successTransfer:
            let vc = SuccessfulTransferRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
