//
//  AddMoneyEnterAmountRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 28/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneyEnterAmountRouter {

    enum Route {
        case back
        case backToRoot
        case confirmAmount(input: AddMoneyConfirmAmountRouter.Input)
        case fundsAddedScreen(input: AddMoneySuccessRouter.Input)
    }
    
    struct InputType {
        let title: String
        let subtitle: String
        let logo: String
        var currentFlow: CashInFlowType = .none
        var selectedLeanBank: BankAccountsListResponseModel.PaymentSources?
        var selectedAccountId: String?
        var selectedDebitCard: CardResponseObjectModel.CardResponseObjectDataModel?
    }
    typealias input = InputType
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: InputType) -> AddMoneyEnterAmountViewController {
        let viewController = AddMoneyEnterAmountViewController.instantiate(fromAppStoryboard: .AddMoneyEnterAmount)
        let presenter = AddMoneyEnterAmountPresenter()
        let router = AddMoneyEnterAmountRouter()
        let interactor = AddMoneyEnterAmountInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.title = input.title
        presenter.subtitle = input.subtitle
        presenter.logo = input.logo
        presenter.currentFlow = input.currentFlow
        presenter.selectedLeanBank = input.selectedLeanBank
        presenter.selectedAccountId = input.selectedAccountId
        presenter.selectedDebitCard = input.selectedDebitCard
        
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyEnterAmountRouter: AddMoneyEnterAmountRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.navigationController?.popViewController(animated: true)
            
        case .backToRoot:
            self.view?.navigationController?.popToRootViewController(animated: true)
            
        case .confirmAmount(let input):
            let vc = AddMoneyConfirmAmountRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        
        case .fundsAddedScreen(let input):
            let vc = AddMoneySuccessRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
