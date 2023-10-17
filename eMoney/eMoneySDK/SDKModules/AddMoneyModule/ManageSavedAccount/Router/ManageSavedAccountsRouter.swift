//
//  ManageSavedAccountsRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/05/2023.
//  
//

import Foundation
import UIKit

class ManageSavedAccountsRouter {

    enum Route {
        case addNewBeneficiary
        case manageCard
        case manageBankAccount(dataSource: [StandardCellModel], actions: [BaseButton])
        case remove(dataSource: [StandardCellModel], actions: [BaseButton])
        case cancelButtonAction
        case updateRootVC
    }
    
    struct Input {
        var bankAccountsList: [BankAccountsListResponseModel.PaymentSources]
        var cardsList: [CardResponseObjectModel.CardResponseObjectDataModel]
    }
    
    // MARK: Properties
    weak var view: UIViewController?
    weak var genericBottomSheet: UIViewController?

    // MARK: Static methods
    static func setupModule(input: Input) -> ManageSavedAccountsViewController {
        let viewController = ManageSavedAccountsViewController.instantiate(fromAppStoryboard: .ManageSavedAccounts)
        let presenter = ManageSavedAccountsPresenter()
        let router = ManageSavedAccountsRouter()
        let interactor = ManageSavedAccountsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        presenter.bankAccountsList = input.bankAccountsList
        presenter.cardsList = input.cardsList
        
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ManageSavedAccountsRouter: ManageSavedAccountsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .addNewBeneficiary:
            let vc = AddMoneyRouter.setupModule(openingState: .managedSavedAccount)
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
            
        case .manageCard:
            let vc = ManageSavedCardRouter.setupModule()
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
            
        case .manageBankAccount(let dataSource, let actions):
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource, actionButtons: actions)
            genericBottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            genericBottomSheet?.modalPresentationStyle = .overCurrentContext
            self.view?.present(genericBottomSheet!, animated: true)
            
        case .remove(let dataSource, let actions):
            self.genericBottomSheet?.dismiss(animated: true, completion: {
                let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource, actionButtons: actions)
                self.genericBottomSheet = GenericBottomSheetRouter.setupModule(input: input)
                self.genericBottomSheet?.modalPresentationStyle = .overCurrentContext
                self.view?.present(self.genericBottomSheet!, animated: true)
            })
            
        case .cancelButtonAction:
            self.genericBottomSheet?.dismiss(animated: true)
            
        case .updateRootVC:
            if let vc = self.view?.navigationController?.viewControllers.first as? AddMoneyViewController {
                vc.reloadViewController()
            }
            
        }
    }
}
