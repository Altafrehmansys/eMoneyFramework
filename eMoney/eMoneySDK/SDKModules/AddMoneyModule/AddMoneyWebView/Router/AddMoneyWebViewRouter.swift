//
//  AddMoneyWebViewRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 01/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneyWebViewRouter {

    enum Route {
        case back
        case loadSuccessScreen(input: AddMoneySuccessRouter.Input)
        case updateRootVC(message: String)
    }
    
    // MARK: Properties
    weak var view: UIViewController?
    
    
    // MARK: - Input
    struct Input {
        var request: URLRequest
        var currentFlow: CashInFlowType = .none
        var addedAmount: String? = nil
        var sourceTitle: String? = nil
    }
    
    // MARK: Static methods
    static func setupModule(input: Input) -> AddMoneyWebViewViewController {
        let viewController = AddMoneyWebViewViewController.instantiate(fromAppStoryboard: .AddMoneyWebView)
        let presenter = AddMoneyWebViewPresenter()
        let router = AddMoneyWebViewRouter()
        let interactor = AddMoneyWebViewInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.request = input.request
        presenter.flowType = input.currentFlow
        presenter.selectedAmount = input.addedAmount ?? ""
        presenter.selectedCardName = input.sourceTitle ?? ""

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyWebViewRouter: AddMoneyWebViewRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.navigationController?.popToRootViewController(animated: true)
            
        case .loadSuccessScreen(let input):
            let vc = AddMoneySuccessRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .updateRootVC(let message):
            if let vc = self.view?.navigationController?.viewControllers.first as? AddMoneyViewController {
                vc.reloadViewController(with: message)
            }
        }
    }
}
