//
//  BankRouter.swift
//  etisalatWallet
//
//  Created by Muhammad Awais Anjum on 28/09/2022.
//  Copyright © 2022 Etisalat UAE. All rights reserved.
//

import UIKit

class BankAlertRouter : NSObject{
    
    // MARK: Properties
    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BankAlertViewController {
        let viewController = BankAlertViewController.instantiate(fromAppStoryboard: .BankAlert)
        let presenter = BankAlertPresenter()
        let router = BankAlertRouter()
        let interactor = BankAlertInteractor()

        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BankAlertRouter: BankAlertWireframe {
    func navigateToPaymentFlow(controller: ReEnterPinViewController){
        view?.navigationController?.pushViewController(controller, animated: true)
    }
    func dismiss(){
        view?.dismiss(animated: true)
    }

}
