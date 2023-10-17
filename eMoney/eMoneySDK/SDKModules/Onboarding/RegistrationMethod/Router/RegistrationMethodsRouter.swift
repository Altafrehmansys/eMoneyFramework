//
//  RegistrationMethodsRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class RegistrationMethodsRouter: RegistrationMethodsRouterProtocol {
    enum Route {
        case back
        case captureIdentity
        case enterEmail
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    class func setupModule() -> RegistrationMethodsViewController {
        
        let viewController = RegistrationMethodsViewController()
        let router = RegistrationMethodsRouter()
        let interactor = RegistrationMethodsInteractor()
        let presenter = RegistrationMethodsPresenter(view: viewController, interactor: interactor, router: router)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.viewController = viewController
        interactor.output = presenter
        return viewController
    }
}

// MARK: - Navigation Methods
extension RegistrationMethodsRouter {
    
    func go(to route: Route) {
        switch route {
        case .back:
            self.viewController?.navigationController?.popViewController(animated: true)
        case .captureIdentity:
            let vc = CaptureIdentityInfoRouter.setupModule()
            viewController?.navigationController?.pushViewController(vc, animated: true)
        case .enterEmail:
            let vc = RegisterEmailRouter.setupModule()
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
