//
//  AddMoneySelectBankRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 25/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneySelectBankRouter {

    enum Route {
        case enterAmount(image: String, name: String)
        case cantFindYourBank
        case loadLeanErrorTray
        case alternateFlow
    }
    
    // MARK: Properties
    struct Input {
        var linkedAccountsList: [BankAccountsListResponseModel.PaymentSources]? = nil
        var type: AddMoneySelectBankPresenter.MethodType.CellType
    }

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: Input) -> AddMoneySelectBankViewController {
        let viewController = AddMoneySelectBankViewController.instantiate(fromAppStoryboard: .AddMoneySelectBank)
        let presenter = AddMoneySelectBankPresenter()
        let router = AddMoneySelectBankRouter()
        let interactor = AddMoneySelectBankInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.linkedAccountsList = input.linkedAccountsList
        presenter.type = input.type

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneySelectBankRouter: AddMoneySelectBankRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .enterAmount(let image, let name):
            
            let input = AddMoneyEnterAmountRouter.input(title: name, subtitle: "", logo: image, currentFlow: .bankAcount)
            let vc = AddMoneyEnterAmountRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .cantFindYourBank:
            let vc = AddBeneficiaryRouter.setupModule()
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .loadLeanErrorTray:
            self.view?.navigationController?.popToRootViewController(animated: true)
            
        case .alternateFlow:
            let vc = AlternateFlowForLeanRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
        }
    }
    
    func openConnectAccountSDK(customerID: String, bankID: String, paymentDestinationID: String?) {
        LeanSDKManager.shared.connectSourceAccount(presentOn: self.view!, customerID: customerID, bankID: bankID, paymentDestinationID: paymentDestinationID ?? nil)
    }
    
    
    func openSuccessConnectedAccountScreen() {
        self.updateRootVC()
        
        let viewController = BankAlertRouter.setupModule()
        viewController.providesPresentationContextTransitionStyle = true
        viewController.definesPresentationContext = true
        viewController.modalPresentationStyle = .overCurrentContext
        
        viewController.dismissClosure = {
            self.view?.navigationController?.popToRootViewController(animated: true)
        }
        view?.present(viewController, animated: true)
    }
    
    func updateRootVC() {
        if let vc = self.view?.navigationController?.viewControllers.first as? AddMoneyViewController {
            vc.reloadViewController()
        }
    }
}
