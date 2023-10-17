//
//  DEWAOfficeRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation
import UIKit

class DEWAOfficeRouter {

    enum Route {
        case autoPayBottomSheet(inputs: GenericBottomSheetRouter.RouterInput?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DEWAOfficeViewController {
        let viewController = DEWAOfficeViewController()
        let presenter = DEWAOfficePresenter()
        let router = DEWAOfficeRouter()
        let interactor = DEWAOfficeInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DEWAOfficeRouter: DEWAOfficeRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .autoPayBottomSheet(inputs):
            navigateToBottomSheet(inputs: inputs)
        }
    }
    
    private func navigateToBottomSheet(inputs: GenericBottomSheetRouter.RouterInput?) {
        let vc = GenericBottomSheetRouter.setupModule(input: inputs)
        self.view?.present(vc, animated: true)
    }
}
