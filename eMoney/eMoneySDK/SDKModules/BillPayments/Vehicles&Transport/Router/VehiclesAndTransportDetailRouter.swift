//
//  VehiclesAndTransportDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class VehiclesAndTransportDetailRouter {

    enum Route {
        case fineDetails(input:BillAccountDetailsParameters?, fineDetails:FinePayBillsResponse?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle:String,selecteItem:ListItems?,billType:BillsAnsTopUpType) -> VehiclesAndTransportDetailViewController {
        let viewController = VehiclesAndTransportDetailViewController.instantiate(fromAppStoryboard: .VehiclesAndTransportDetail)
        let presenter = VehiclesAndTransportDetailPresenter()
        let router = VehiclesAndTransportDetailRouter()
        let interactor = VehiclesAndTransportDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.navTitle = navTitle
        presenter.selectedItem = selecteItem
        presenter.billType = billType
        
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension VehiclesAndTransportDetailRouter: VehiclesAndTransportDetailRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .fineDetails(input,fineDetails):
            let vc = VehiclesAndTransportFinesDetailsRouter.setupModule(input:input,fineDetails: fineDetails)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
