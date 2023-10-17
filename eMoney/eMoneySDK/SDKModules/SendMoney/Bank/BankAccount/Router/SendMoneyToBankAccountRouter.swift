//
//  SendMoneyToBankAccountRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyToBankAccountRouter {

    enum Route {
        case showIBANInfo(dataSource: [StandardCellModel])
        case navigateToSendMoneyEnterAmount
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SendMoneyToBankAccountViewController {
        let viewController = SendMoneyToBankAccountViewController.instantiate(fromAppStoryboard: .SendMoneyToBankAccount)
        let presenter = SendMoneyToBankAccountPresenter()
        let router = SendMoneyToBankAccountRouter()
        let interactor = SendMoneyToBankAccountInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension SendMoneyToBankAccountRouter: SendMoneyToBankAccountRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .showIBANInfo(let dataSource):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case.navigateToSendMoneyEnterAmount:
            let vc = SendMoneyEnterAmountRouter.setupModule()
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
