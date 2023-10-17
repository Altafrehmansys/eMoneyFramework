//
//  SelectLanguageRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//  
//

import Foundation
import UIKit

class SelectLanguageRouter {
    enum Route {
        case walkThrough
        case tempCaseWithValue(value:String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SelectLanguageViewController {
        let viewController = SelectLanguageViewController.instantiate(fromAppStoryboard: .SelectLanguage)
        let presenter = SelectLanguagePresenter()
        let router = SelectLanguageRouter()
        let interactor = SelectLanguageInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SelectLanguageRouter: SelectLanguageRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .walkThrough:
            let vc = WalkthroughIntroRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
            break
        case .tempCaseWithValue(let value):
            break
        }
    }
}
