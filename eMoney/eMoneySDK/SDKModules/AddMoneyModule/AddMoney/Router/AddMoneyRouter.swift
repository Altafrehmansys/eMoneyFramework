//
//  AddMoneyRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneyRouter {

    enum Route {
        case back(withAnimation: Bool)
        case showLeanAccount(input: AddMoneyEnterAmountRouter.InputType)
        case applePay(input: AddMoneyEnterAmountRouter.InputType)
        case manageSavedAccounts(input: ManageSavedAccountsRouter.Input)
        case selectBank(linkedAccountsList: [BankAccountsListResponseModel.PaymentSources])
        case paymentMachine(getLocationNearByType: String)
        case creditDebitCard
        case cashAdvance(input: AddMoneyEnterAmountRouter.InputType)
        case payWithCard(input: AddMoneyEnterAmountRouter.InputType)
        case loadWebViewWith(input: AddMoneyWebViewRouter.Input)
        case leanCoolOffBottomSheet(interval: Int)
    }
    
    // MARK: Properties
    weak var view: UIViewController?
    
    // MARK: Static methods
    static func setupModule(openingState: AddMoneyPresenter.ScreenOpeningStates = .normal) -> AddMoneyViewController {
        let viewController = AddMoneyViewController.instantiate(fromAppStoryboard: .AddMoney)
        let presenter = AddMoneyPresenter()
        let router = AddMoneyRouter()
        let interactor = AddMoneyInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.openState = openingState

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyRouter: AddMoneyRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        var vc = UIViewController()
        
        switch route {
        case .back(let animation):
            self.view?.dismiss(animated: animation)
            return
            
        case .showLeanAccount(input: let input):
            vc = AddMoneyEnterAmountRouter.setupModule(input: input)
            
        case .manageSavedAccounts(input: let input):
            vc = ManageSavedAccountsRouter.setupModule(input: input)
            
        case .selectBank(let linkedAccountsList):
//            let input = AddMoneySelectBankRouter.Input(linkedAccountsList: linkedAccountsList, type: .general)
//            vc = AddMoneySelectBankRouter.setupModule(input: input)
            print("This case will not be handled")
            
        case .creditDebitCard:
            vc = AddNewCardRouter.setupModule()
            
        case .applePay(input: let input):
            vc = AddMoneyEnterAmountRouter.setupModule(input: input)
                        
        case .paymentMachine(let getLocationNearByType):
//            vc = PaymentMachinesRouter.setupModule(getLocationNearByType: getLocationNearByType)
            print("This case will not be handled")
        case .cashAdvance(let input):
            vc = AddMoneyEnterAmountRouter.setupModule(input: input)
             
        case .payWithCard(let input):
            vc = AddMoneyEnterAmountRouter.setupModule(input: input)
            
        case .loadWebViewWith(let input):
            vc = AddMoneyWebViewRouter.setupModule(input: input)
            
        case .leanCoolOffBottomSheet(let interval):
//            vc = LeanCoolOffBottomSheetRouter.setupModule(coolDownTime: interval - 1)
//            vc.modalPresentationStyle = .overCurrentContext
//            self.view?.present(vc, animated: true)
//            return
            print("This case will not be handled")
        }
        
        
        if let navigation = self.view?.navigationController {
            navigation.pushViewController(vc, animated: true)
        } else {
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
}
