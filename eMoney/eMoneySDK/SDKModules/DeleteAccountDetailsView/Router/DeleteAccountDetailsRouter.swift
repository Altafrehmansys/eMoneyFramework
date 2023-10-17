//
//  DeleteAccountDetailsRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation
import UIKit

class DeleteAccountDetailsRouter {

    enum Route {

    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(viewData: DeleteAccountDetailsViewData, delegate: DeleteAccountDetailsViewDelegate?) -> DeleteAccountDetailsViewController {
        let viewController = DeleteAccountDetailsViewController()
        viewController.delegate = delegate
        let presenter = DeleteAccountDetailsPresenter()
        let router = DeleteAccountDetailsRouter()
        let interactor = DeleteAccountDetailsInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.viewData = viewData
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension DeleteAccountDetailsRouter: DeleteAccountDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {

        }
    }
}
