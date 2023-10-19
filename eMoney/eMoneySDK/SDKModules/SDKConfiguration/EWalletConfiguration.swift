//
//  EWalletConfiguration.swift
//  eMoneySDK
//
//  Created by Altaf Ur Rehman on 10/10/2023.
//

import Foundation
import UIKit

public struct EWalletConfiguration {
    let partnerName: String
    let clientId: String
    let theme: EWalletTheme?
    
    public init(partnerName: String, clientId: String, theme: EWalletTheme?) {
        self.partnerName = partnerName
        self.clientId = clientId
        self.theme = theme
    }
}

public class EWalletSDK {
    let configuration: EWalletConfiguration
    
    
    public init(configuration: EWalletConfiguration) {
        self.configuration = configuration
        self.loadLanguagePack()
    }
    
    public func startWithOnboarding(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?) {
        let onboardingView = OnboardingViewController.instantiate(fromAppStoryboard: .Onboarding)
        onboardingView.modalPresentationStyle = .overCurrentContext
        onboardingView.onSuccess = onSuccess
        onboardingView.onFailure = onFailure
        onboardingView.msisdn = msisdn
        onboardingView.clientID = configuration.clientId
        SDKColors.shared.clientID = configuration.clientId
        onboardingView.partnerName = configuration.partnerName
        onboardingView.receivedTheme = configuration.theme
        controller.present(onboardingView, animated: true)
    }
    
    public func startWithAddMoney(in controller: UIViewController, msisdn: String, onSuccess: ((String) -> ())?, onFailure: ((String, String) -> ())?) {
        let onboardingView = OnboardingViewController.instantiate(fromAppStoryboard: .AddMoneySDK)
        onboardingView.modalPresentationStyle = .overCurrentContext
        onboardingView.onSuccess = onSuccess
        onboardingView.onFailure = onFailure
        onboardingView.msisdn = msisdn
        onboardingView.clientID = configuration.clientId
        SDKColors.shared.clientID = configuration.clientId
        onboardingView.partnerName = configuration.partnerName
        onboardingView.receivedTheme = configuration.theme
        controller.present(onboardingView, animated: true)
    }
    
    public func loadLanguagePack() {
        if UIApplication.isFirstLaunchAfterUpdate(){
            LocaleManager.shared.LoadLanguagePackFromLocalFile()
        } else {
            LocaleManager.shared.loadLanguagePack()
        }
    }
}
