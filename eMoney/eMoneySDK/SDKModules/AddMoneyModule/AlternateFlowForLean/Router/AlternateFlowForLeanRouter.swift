//
//  AlternateFlowForLeanRouter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 22/06/2023.
//  
//

import Foundation
import UIKit

class AlternateFlowForLeanRouter {

    enum Route {
        case back
        case selectBank
        case selectLeanBank
        case enterAmountVC(input: AddMoneyEnterAmountRouter.InputType)
        case loadWebViewWith(input: AddMoneyWebViewRouter.Input)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AlternateFlowForLeanViewController {
        let viewController = AlternateFlowForLeanViewController.instantiate(fromAppStoryboard: .AlternateFlowForLean)
        let presenter = AlternateFlowForLeanPresenter()
        let router = AlternateFlowForLeanRouter()
        let interactor = AlternateFlowForLeanInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AlternateFlowForLeanRouter: AlternateFlowForLeanRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .back:
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    topVC.navigationController?.popToRootViewController(animated: true)
                }
            })
            
        case .selectBank:
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = AddMoneySelectBankRouter.setupModule(input: AddMoneySelectBankRouter.Input(type: .epg))
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                    topVC.navigationController?.removeMiddleViewControllersExceptFirstAndLast()
                }
            })
            
        case .selectLeanBank:
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = AddMoneySelectBankRouter.setupModule(input: AddMoneySelectBankRouter.Input(type: .lean))
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                    topVC.navigationController?.removeMiddleViewControllersExceptFirstAndLast()
                }
            })
            
        case .enterAmountVC(input: let input):
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = AddMoneyEnterAmountRouter.setupModule(input: input)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                    topVC.navigationController?.removeMiddleViewControllersExceptFirstAndLast()
                }
            })
            
        case .loadWebViewWith(let input):
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = AddMoneyWebViewRouter.setupModule(input: input)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                    topVC.navigationController?.removeMiddleViewControllersExceptFirstAndLast()
                }
            })
        }
    }
}
