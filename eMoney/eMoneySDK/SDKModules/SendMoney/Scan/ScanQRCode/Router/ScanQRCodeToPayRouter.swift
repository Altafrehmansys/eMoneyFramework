//
//  ScanQRCodeToPayRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/05/2023.
//  
//

import Foundation
import UIKit

class ScanQRCodeToPayRouter {

    enum Route {
        case moveToEnterPaymentAmountScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ScanQRCodeToPayViewController {
        let viewController = ScanQRCodeToPayViewController.instantiate(fromAppStoryboard: .ScanQRCodeToPay)
        let presenter = ScanQRCodeToPayPresenter()
        let router = ScanQRCodeToPayRouter()
        let interactor = ScanQRCodeToPayInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ScanQRCodeToPayRouter: ScanQRCodeToPayRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .moveToEnterPaymentAmountScreen:
            let vc = SendMoneyEnterAmountRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
