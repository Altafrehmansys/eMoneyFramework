//
//  SuccessfulTransferRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SuccessfulTransferRouter {

    enum Route {
        case homePage
        case transferStatus
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SuccessfulTransferViewController {
        let viewController = SuccessfulTransferViewController.instantiate(fromAppStoryboard: .SuccessfulTransfer)
        let presenter = SuccessfulTransferPresenter()
        let router = SuccessfulTransferRouter()
        let interactor = SuccessfulTransferInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SuccessfulTransferRouter: SuccessfulTransferRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .homePage:
        let vc = WalkthroughImtRouter.setupModule()
        view?.navigationController?.pushViewController(vc, animated: true)
        case .transferStatus:
            let vc = TransferStatusRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            view?.present(vc, animated: true)
        }
    }
}
