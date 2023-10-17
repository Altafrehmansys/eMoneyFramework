//
//  ReviewEidRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 22/04/2023.
//  
//

import Foundation
import UIKit

class ReviewEidRouter {

    enum Route {
        case verifyIdentity
        case enterEmail
        case dismissUpgradeFlow
    }
    
    // MARK: Properties

    weak var view: ReviewEidViewController?
    
    var popToViewController:AnyClass? = nil

    // MARK: Static methods

    static func setupModule() -> ReviewEidViewController {
        let viewController = ReviewEidViewController.instantiate(fromAppStoryboard: .ReviewEid)
        let presenter = ReviewEidPresenter()
        let router = ReviewEidRouter()
        let interactor = ReviewEidInteractor()
        
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ReviewEidRouter: ReviewEidRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .verifyIdentity:
            let vc = CaptureIdentityInfoRouter.setupModule()
            vc.isScreenTypeSelfi = true
            vc.updateType = view?.updateType
            view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .enterEmail:
            let vc = RegisterEmailRouter.setupModule()
            GlobalData.shared.registrationType = .physicalKyc
            view?.navigationController?.pushViewController(vc, animated: true)
        case .dismissUpgradeFlow:
            view?.dismiss(animated: true)
        }
    }
}
