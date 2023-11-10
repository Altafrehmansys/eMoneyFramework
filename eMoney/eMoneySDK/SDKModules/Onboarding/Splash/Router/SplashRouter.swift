//
//  SplashRouter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/05/2023.
//  
//

import Foundation
import UIKit

class SplashRouter {

    enum Route {
        case softUpdate
        case hardUpdate
        case login
        case walkthrough
        case selectLanguage
        //FIXME:- this is just for routing purpose
        case accountDetails
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(vc:SplashViewController) -> SplashViewController {
        let viewController = vc//SplashViewController.instantiate(fromAppStoryboard: .Splash)
        let presenter = SplashPresenter()
        let router = SplashRouter()
        let interactor = SplashInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SplashRouter: SplashRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        //FIXME
//        let vc = AccountDetailsRouter.setupModule()
//        CommonMethods.setRootViewController(viewController: vc)
//        return
        switch route {
        case .softUpdate:
            let vc = ThankyouRouter.setupModule()
            vc.screenTypeEnum = .softUpdate
            view?.navigationController?.pushViewController(vc, animated: true)
        case .hardUpdate:
            let vc = ThankyouRouter.setupModule()
            vc.screenTypeEnum = .hardUpdate
            view?.navigationController?.pushViewController(vc, animated: true)
        case .login:
            let vc = LoginRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        case .walkthrough:
            let vc = WalkthroughIntroRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        case .selectLanguage:
            
            let vc = SelectLanguageRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        //FIXME
        case .accountDetails:
//            let vc = AccountDetailsRouter.setupModule()
//            CommonMethods.setRootViewController(viewController: vc)
            break
            
        }
    }
}
