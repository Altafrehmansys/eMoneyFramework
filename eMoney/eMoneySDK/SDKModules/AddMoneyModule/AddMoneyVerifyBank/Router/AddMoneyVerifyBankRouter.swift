//
//  AddMoneyVerifyBankRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneyVerifyBankRouter {

    enum Route {
        case showIBANInfo(dataSource: [StandardCellModel])
        case enterAmountVC(bankLogo: String, bankName: String)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(bankLogo: String, bankName: String) -> AddMoneyVerifyBankViewController {
        let viewController = AddMoneyVerifyBankViewController.instantiate(fromAppStoryboard: .AddMoneyVerifyBank)
        let presenter = AddMoneyVerifyBankPresenter()
        let router = AddMoneyVerifyBankRouter()
        let interactor = AddMoneyVerifyBankInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.bankLogo = bankLogo
        presenter.bankName = bankName

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMoneyVerifyBankRouter: AddMoneyVerifyBankRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .showIBANInfo(let dataSource):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case .enterAmountVC(let bankLogo, let bankName):
            let input = AddMoneyEnterAmountRouter.input(title: bankName, subtitle: "", logo: bankLogo)
            let vc = AddMoneyEnterAmountRouter.setupModule(input: input)
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
