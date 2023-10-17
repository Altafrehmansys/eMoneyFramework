//
//  SendMoneyRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyRouter {

    enum Route {
        case sendMoneyToBankAccount
        case sendMoneyToAbroad
        case sendMoneyByQRCode
        case loadAllBeneficiars
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneyViewController {
        let viewController = SendMoneyViewController.instantiate(fromAppStoryboard: .SendMoney)
        let presenter = SendMoneyPresenter()
        let router = SendMoneyRouter()
        let interactor = SendMoneyInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SendMoneyRouter: SendMoneyRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .sendMoneyToBankAccount:
            let vc = SendMoneyToBankAccountRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case.sendMoneyByQRCode:
            let vc = ScanQRCodeToPayRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .sendMoneyToAbroad:
            let vc = AddBankBeneficiaryRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .loadAllBeneficiars:
            let vc = MyBeneficiariesRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
