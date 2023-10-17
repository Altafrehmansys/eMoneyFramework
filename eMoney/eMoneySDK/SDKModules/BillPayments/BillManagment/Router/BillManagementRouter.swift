//
//  BillManagementRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class BillManagementRouter {

    enum Route {
        case editAccount(dataSource: [StandardCellModel],actions:[BaseButton])
        case deleteBiller(dataSource:DeleteAccountDetailsViewData,delegate:DeleteAccountDetailsViewDelegate)
        case downloadStatement(dataSource: [StandardCellModel],actions:[BaseButton])
        
        case dismiss
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> BillManagementViewController {
        let viewController = BillManagementViewController.instantiate(fromAppStoryboard: .BillManagement)
        let presenter = BillManagementPresenter()
        let router = BillManagementRouter()
        let interactor = BillManagementInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillManagementRouter: BillManagementRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .editAccount(let dataSource,let actions):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case.deleteBiller(let dataSource,let delegate):
            let vc  = DeleteAccountDetailsRouter.setupModule(viewData: dataSource, delegate: delegate)
            vc.modalPresentationStyle = .overCurrentContext
            self.view?.present(vc, animated: true)
        case .downloadStatement(let dataSource,let actions):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case .dismiss:
            self.view?.dismiss(animated: true)
        }
    }
}
