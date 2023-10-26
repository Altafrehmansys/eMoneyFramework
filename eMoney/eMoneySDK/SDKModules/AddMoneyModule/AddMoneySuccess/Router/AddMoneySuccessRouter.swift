//
//  AddMoneySuccessRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneySuccessRouter {

    enum Route {
        case shareSheet(content: [Any])
        case returnBackToHome
    }
    
    
    struct Input {
        var title: String
        var subtitle: String? = nil
        var switchTitle: String? = nil
        var amount: String
        var transactionID: String? = nil
        var currentFlow: CashInFlowType = .none
        var selectedLeanBank: BankAccountsListResponseModel.PaymentSources? = nil
        var selectedLeanAccount: BankAccountsListResponseModel.Accounts? = nil
        var cashInWithBank: FundInResponseModel? = nil
    }
    
    
    
    // MARK: Properties
    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(input: Input) -> AddMoneySuccessViewController {
        let viewController = AddMoneySuccessViewController.instantiate(fromAppStoryboard: .AddMoneySuccess)
        let presenter = AddMoneySuccessPresenter()
        let router = AddMoneySuccessRouter()
        let interactor = AddMoneySuccessInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        
        presenter.title = input.title
        presenter.subtitle = input.subtitle ?? ""
        presenter.switchTitle = input.switchTitle ?? ""
        presenter.amount = input.amount
        presenter.transactionID = input.transactionID ?? ""
        presenter.currentFlow = input.currentFlow
        presenter.selectedLeanBank = input.selectedLeanBank
        presenter.selectedLeanAccount = input.selectedLeanAccount
        presenter.cashInWithBank = input.cashInWithBank

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneySuccessRouter: AddMoneySuccessRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .shareSheet(let items):
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            view?.present(ac, animated: true)
            
        case .returnBackToHome:
            SDKColors.shared.onSuccess?("funds_added_successfully".localized)
            view?.dismiss(animated: true)
//            let vc = CustomTabbarViewController()
//            CommonMethods.setRootViewControllerWithoutNavigation(viewController: vc)
        }
    }
}
