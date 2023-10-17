//
//  AddReceiptRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 07/06/2023.
//  
//

import Foundation
import UIKit

class AddReceiptRouter {

    enum Route {
        case tempCase
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddReceiptViewController {
        let viewController = AddReceiptViewController.instantiate(fromAppStoryboard: .AddReceipt)
        let presenter = AddReceiptPresenter()
        let router = AddReceiptRouter()
        let interactor = AddReceiptInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddReceiptRouter: AddReceiptRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .tempCase:
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
