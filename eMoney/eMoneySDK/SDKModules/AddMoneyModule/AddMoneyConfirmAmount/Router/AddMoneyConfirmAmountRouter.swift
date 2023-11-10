//
//  AddMoneyConfirmAmountRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneyConfirmAmountRouter {

    enum Route {
        case back
        case loadWebViewWith(input: AddMoneyWebViewRouter.Input)
        case loadSuccessScreen(input: AddMoneySuccessRouter.Input)
        case loadLeanErrorTray
        case alternateFlow
        case loadOTPScreen(msisdn: String, addingText:String, amount: String, toTitle: String)
    }
    
    struct Input {
        var title: String
        var subtitle: String
        var logo: String
        var amount: String
        var flowType: CashInFlowType
        var selectedLeanBank: BankAccountsListResponseModel.PaymentSources?
        var selectedAccountId: String?
        var selectedDebitCard: CardResponseObjectModel.CardResponseObjectDataModel?
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: Input) -> AddMoneyConfirmAmountViewController {
        let viewController = AddMoneyConfirmAmountViewController.instantiate(fromAppStoryboard: .AddMoneyConfirmAmount)
        let presenter = AddMoneyConfirmAmountPresenter()
        let router = AddMoneyConfirmAmountRouter()
        let interactor = AddMoneyConfirmAmountInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.title = input.title
        presenter.subtitle = input.subtitle
        presenter.logo = input.logo
        presenter.amount = input.amount
        presenter.currentFlow = input.flowType
        presenter.selectedLeanBank = input.selectedLeanBank
        presenter.selectedAccountId = input.selectedAccountId
        presenter.selectedDebitCard = input.selectedDebitCard

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyConfirmAmountRouter: AddMoneyConfirmAmountRouterProtocol {
    
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.navigationController?.popToRootViewController(animated: true)
        case .loadWebViewWith(let input):
            let vc = AddMoneyWebViewRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        
        case .loadSuccessScreen(let input):
            let vc = AddMoneySuccessRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .loadLeanErrorTray:
            self.view?.navigationController?.popToRootViewController(animated: true)
            
        case .alternateFlow:
//            let vc = AlternateFlowForLeanRouter.setupModule()
//            vc.modalPresentationStyle = .overCurrentContext
//            self.view?.present(vc, animated: true)
            print("This will not be handled in sdk")
            
        case .loadOTPScreen(let msisdn, let addingText, let amount, let toTitle):
            let input = OtpPopupRouter.Input(msisdn: msisdn, addingText: addingText, amount: amount, toTitle: toTitle, userJourney: .onboarding)
            let vc = OtpPopupRouter.setupModule(input: input)
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self.view as? OtpPopupDelegate
            self.view?.present(vc, animated: true)
        }
    }
    
    func navigateToPayLeanSDK(paymentIntent: String, selectedSouceBankID: String) {
        guard let view = self.view else { return }
        LeanSDKManager.shared.payFromLeanSDK(presentOn: view, paymentIntentID: paymentIntent, bankID: selectedSouceBankID)
    }
}
