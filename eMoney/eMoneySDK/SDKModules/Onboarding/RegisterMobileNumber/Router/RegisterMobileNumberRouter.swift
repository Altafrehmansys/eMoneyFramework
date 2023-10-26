//
//  RegisterMobileNumberRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation
import UIKit

class RegisterMobileNumberRouter {
    
    enum Route {
        case navigateToOtp(msisdn: String, ref: RegisterMobileNumberViewController)
        case navigateToPrivacy(privacyEnumType:PrivacypolicyType)
        case dismiss
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> RegisterMobileNumberViewController {
        let viewController = RegisterMobileNumberViewController.instantiate(fromAppStoryboard: .RegisterMobileNumber)
        let presenter = RegisterMobileNumberPresenter()
        let router = RegisterMobileNumberRouter()
        let interactor = RegisterMobileNumberInteractor()
        
        viewController.presenter =  presenter
    
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
    
    static func setupModule(vc: RegisterMobileNumberViewController) -> RegisterMobileNumberViewController {
        let viewController = vc
        let presenter = RegisterMobileNumberPresenter()
        let router = RegisterMobileNumberRouter()
        let interactor = RegisterMobileNumberInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}

extension RegisterMobileNumberRouter: RegisterMobileNumberRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .navigateToOtp(let msisdn, let thisVC):
            let vc = VerifyMobileNumberRouter.setupModule()
            vc.isNumberChange = CommonMethods.checkIfNumberChange(msisd: msisdn)
            GlobalData.shared.msisdn = msisdn
            GlobalData.shared.lastNumberInput = msisdn
            vc.msisdn = msisdn
            vc.delegate = thisVC.delegate
            view?.navigationController?.pushViewController(vc, animated: true)
            
        case .navigateToPrivacy(let privacyEnumType):
            let vc = TermsConditionsRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            vc.enumPrivacyType = privacyEnumType
            vc.isLoadDirectUrl = true
            view?.present(vc, animated: true)
        case .dismiss:
            view?.dismiss(animated: true)
        }
    }
}
