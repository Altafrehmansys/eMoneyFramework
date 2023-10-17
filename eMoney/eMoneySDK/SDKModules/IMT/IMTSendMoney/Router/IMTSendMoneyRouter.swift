//
//  IMTSendMoneyRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class IMTSendMoneyRouter {

    enum Route {
        case countrySelection
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> IMTSendMoneyViewController {
        let viewController = IMTSendMoneyViewController.instantiate(fromAppStoryboard: .IMTSendMoney)
        let presenter = IMTSendMoneyPresenter()
        let router = IMTSendMoneyRouter()
        let interactor = IMTSendMoneyInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension IMTSendMoneyRouter: IMTSendMoneyRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .countrySelection:
            let vc = CountrySelectionRouter.setupModule()
            vc.delegte = view as? IMTSendMoneyViewController
            vc.modalPresentationStyle = .overFullScreen
            view?.present(vc, animated: true)
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
