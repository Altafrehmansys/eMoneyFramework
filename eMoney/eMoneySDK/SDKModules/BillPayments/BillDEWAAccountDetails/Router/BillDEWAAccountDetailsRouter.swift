//
//  BillDEWAAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation
import UIKit

class BillDEWAAccountDetailsRouter {

    enum Route {
        case easyPayInfo
        case pay
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BillDEWAAccountDetailsViewController {
        let viewController = BillDEWAAccountDetailsViewController()
        let presenter = BillDEWAAccountDetailsPresenter()
        let router = BillDEWAAccountDetailsRouter()
        let interactor = BillDEWAAccountDetailsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillDEWAAccountDetailsRouter: BillDEWAAccountDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .easyPayInfo:
            showEasypayInfoView()
        case .pay:
            navigateToDEWAWalletView()
        }
    }
    
    private func showEasypayInfoView() {
        let vc = BillDEWAEasypayNumberInfoRouter.setupModule()
        vc.modalPresentationStyle = .overFullScreen
        self.view?.present(vc, animated: false)
    }
    
    private func navigateToDEWAWalletView() {
        let payVC = BillDEWAWalletBalanceRouter.setupModule()
        self.view?.navigationController?.pushViewController(payVC, animated: true)
    }
}
