//
//  VerifyMobileNumberRouter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation
import UIKit

class VerifyMobileNumberRouter {
    
    enum Route {
        case SelectMethod
        case captureIdentity(delegate: SendDataSDK?)
        case RegisterPin(otp:String)
        case FastTrack
        case Login
        case failedOtp(model:VerifyMobileNumberResponseModel)
        case popToRootView
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> VerifyMobileNumberViewController {
        let viewController = VerifyMobileNumberViewController.instantiate(fromAppStoryboard: .VerifyMobileNumber)
        let presenter = VerifyMobileNumberPresenter()
        let router = VerifyMobileNumberRouter()
        let interactor = VerifyMobileNumberInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}

extension VerifyMobileNumberRouter: VerifyMobileNumberRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .SelectMethod:
            let vc = RegistrationMethodsRouter.setupModule()
            view?.navigationController?.pushViewController(vc, animated: true)
        case .captureIdentity(let delegate):
            let vc = CaptureIdentityInfoRouter.setupModule()
            if SDKColors.shared.flowName != SDKFlowName.registration.rawValue {
                vc.updateType = .updateEidAndSelfi
            }
            vc.delegate = delegate
            view?.navigationController?.pushViewController(vc, animated: true)
        case .RegisterPin(let otp):
            let vc = RegisterPinRouter.setupModule()
            vc.userJourneyEnum = .forgotPin
            vc.otpInputCode = otp
            view?.navigationController?.pushViewController(vc, animated: true)
        case .FastTrack:
            let vc = ThankyouRouter.setupModule()
            vc.screenTypeEnum = .fastTrack
            view?.navigationController?.pushViewController(vc, animated: true)
        case .Login:
            let vc = LoginRouter.setupModule()
            CommonMethods.setRootViewController(viewController: vc)
        case .failedOtp(let model):
            let vc = FailedOtpRouter.setupModule()
            vc.responseObj = model
            view?.navigationController?.pushViewController(vc, animated: true)
        case .popToRootView:
            view?.navigationController?.popViewController(animated: true)
        }
        
    }
}

