//
//  ReportLostCardRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation
import UIKit

class ReportLostCardRouter {

    enum Route {
        case presentReportCardSuccessScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ReportLostCardViewController {
        let viewController = ReportLostCardViewController.instantiate(fromAppStoryboard: .ReportLostCard)
        let presenter = ReportLostCardPresenter()
        let router = ReportLostCardRouter()
        let interactor = ReportLostCardInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ReportLostCardRouter: ReportLostCardRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .presentReportCardSuccessScreen:
            let vc = CancelCardRouter.setupModule()
            vc.modalPresentationStyle = .fullScreen
            self.view?.navigationController?.present(vc, animated: true)
        }
    }
}
