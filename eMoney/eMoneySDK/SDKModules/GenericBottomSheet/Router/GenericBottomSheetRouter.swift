//
//  GenericBottomSheetRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation
import UIKit

class GenericBottomSheetRouter {

    enum Route {
        case back
    }
    
    struct RouterInput {
        var dataSource: [StandardCellModel]
        var actionButtons: [BaseButton]? = nil
    }
    
    // MARK: Properties
    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: RouterInput? = nil) -> GenericBottomSheetViewController {
        let viewController = GenericBottomSheetViewController.instantiate(fromAppStoryboard: .GenericBottomSheet)
        let presenter = GenericBottomSheetPresenter()
        let router = GenericBottomSheetRouter()
        let interactor = GenericBottomSheetInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.dataSource = input?.dataSource
        presenter.actions = input?.actionButtons

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension GenericBottomSheetRouter: GenericBottomSheetRouterProtocol {
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.dismiss(animated: true)
        }
    }
}
