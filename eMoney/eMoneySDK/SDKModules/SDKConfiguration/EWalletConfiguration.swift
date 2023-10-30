//
//  EWalletConfiguration.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 10/10/2023.
//

import Foundation
import UIKit

public enum Environment: String {
    case staging
    case production
}
enum flowName: String {
    case registration = "registration"
    case addMoney = "AddMoney"
    case changePin = "ChangePin"
}

public struct EWalletConfiguration {
    let partnerName: String
    let clientId: String
    let theme: EWalletTheme?
    let environment: Environment?
    
    public init(partnerName: String, clientId: String, environment: Environment, theme: EWalletTheme?) {
        self.partnerName = partnerName
        self.clientId = clientId
        self.theme = theme
        self.environment = environment
    }
}

public class EWalletSDK {
    let configuration: EWalletConfiguration
    
    public init(configuration: EWalletConfiguration) {
        self.configuration = configuration
        self.loadLanguagePack()
        setConfiguration()
    }
    
    private func setConfiguration() {
        SDKColors.shared.clientID = configuration.clientId
        SDKColors.shared.setReceivedColor(theme: configuration.theme)
        SDKColors.shared.environment = configuration.environment
    }
    
    public func startWithOnboarding(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?) {
//        guard CommonMethods.validateUAEMobileNumber(phoneNumber: msisdn) else {
//            onFailure?("", "phone_number_error_pre_paid_and_post_paid".localized)
//            return
//        }
        SDKColors.shared.flowName = flowName.registration.rawValue
        SDKNavigationStack.shared.baseViewController = controller
        
        let onboardingView = OnboardingViewController.instantiate(fromAppStoryboard: .Onboarding)
        onboardingView.modalPresentationStyle = .overCurrentContext
        onboardingView.onSuccess = onSuccess
        onboardingView.onFailure = onFailure
        onboardingView.msisdn = msisdn
        onboardingView.clientID = configuration.clientId
        onboardingView.partnerName = configuration.partnerName
        onboardingView.receivedTheme = configuration.theme
        controller.present(onboardingView, animated: true)
    }
    
    public func startWithAddMoney(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?) {
//        guard CommonMethods.validateUAEMobileNumber(phoneNumber: msisdn) else {
//            onFailure?("", "phone_number_error_pre_paid_and_post_paid".localized)
//            return
//        }
        SDKColors.shared.flowName = flowName.addMoney.rawValue
        SDKNavigationStack.shared.baseViewController = controller
        
        let onboardingView = OnboardingViewController.instantiate(fromAppStoryboard: .AddMoneySDK)
        onboardingView.modalPresentationStyle = .overCurrentContext
        onboardingView.onSuccess = onSuccess
        onboardingView.onFailure = onFailure
        onboardingView.msisdn = msisdn
        onboardingView.clientID = configuration.clientId
        onboardingView.partnerName = configuration.partnerName
        onboardingView.receivedTheme = configuration.theme
        controller.present(onboardingView, animated: true)
        
    }
    
    public func startForgetPin(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?) {
//        guard CommonMethods.validateUAEMobileNumber(phoneNumber: msisdn) else {
//            onFailure?("", "phone_number_error_pre_paid_and_post_paid".localized)
//            return
//        }
        SDKColors.shared.flowName = flowName.registration.rawValue
        SDKNavigationStack.shared.baseViewController = controller
        SDKColors.shared.onSuccess = onSuccess
        SDKColors.shared.onFailure = onFailure
        SDKColors.shared.msisdn = msisdn
        let vc = OtpForgotPinPopupRouter.setupModule()
        vc.modalPresentationStyle = .popover
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .popover
        nc.view.layer.cornerRadius = 20.0
        nc.view.layer.masksToBounds = true
        controller.present(nc, animated: true)
    }
    
    public func startChangePin(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?)
    {
        SDKColors.shared.flowName = flowName.changePin.rawValue
        SDKNavigationStack.shared.baseViewController = controller
        
        let onboardingView = OnboardingViewController.instantiate(fromAppStoryboard: .AddMoneySDK)
        onboardingView.modalPresentationStyle = .overCurrentContext
        onboardingView.onSuccess = onSuccess
        onboardingView.onFailure = onFailure
        onboardingView.msisdn = msisdn
        onboardingView.clientID = configuration.clientId
        onboardingView.partnerName = configuration.partnerName
        onboardingView.receivedTheme = configuration.theme
        controller.present(onboardingView, animated: true)
    }
    
    public func enableLogs(_ isEnable: Bool) {
        SDKColors.shared.logsEnabled = isEnable
    }
    
    private func loadLanguagePack() {
//        LocaleManager.setAppleLanguageTo("en")
//        if UIApplication.isFirstLaunchAfterUpdate(){
            LocaleManager.shared.LoadLanguagePackFromLocalFile()
//        } else {
//            LocaleManager.shared.loadLanguagePack()
//        }
    }
}

public enum EWalletErrorCode: String {
    case ERROR
    case GENERAL_ERROR
    case NO_DATA
    case NETWORK_ERROR
    case SESSION_EXPIRED
    case AML_FAILURE
    case BLOCKED_ACCOUNT
    case SUSPENDED_ACCOUNT
    case DEVICE_CHANGE
    case LIMITED
    case LOCKED
    case ONBOARDING_ALREADY_REGISTERED
    case ONBOARDING_REGISTERED_RESET_PIN
    case INVALID_MISDIN
    case ROLE_ACCESS_NOT_GRANTED
}

