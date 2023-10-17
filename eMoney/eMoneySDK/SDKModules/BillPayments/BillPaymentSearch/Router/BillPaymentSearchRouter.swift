//
//  BillPaymentSearchRouter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 08/06/2023.
//  
//

import Foundation
import UIKit

class BillPaymentSearchRouter {

    enum Route {
        case bottomSheetWithBillsListItems(title:String,dataSource:[ListItems])
        case navigateToBillAccountDetail(navTitle:String,selectedItem:ListItems)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(allBills:[ListItems]) -> BillPaymentSearchViewController {
        let viewController = BillPaymentSearchViewController()
        let presenter = BillPaymentSearchPresenter()
        let router = BillPaymentSearchRouter()
        let interactor = BillPaymentSearchInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.allBills = allBills
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension BillPaymentSearchRouter: BillPaymentSearchRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .bottomSheetWithBillsListItems(let title,let listItems):
            let bottomSheet = BottomSheetCollectionViewRouter.setupModule(title:title,listItems: listItems)
            bottomSheet.hidesBottomBarWhenPushed = true
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case .navigateToBillAccountDetail(let title,let listItems):
            let vc = BillAccountDetailsRouter.setupModule(navTitle: title, selecteItem: listItems, billType:listItems.type, codeList: nil)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
