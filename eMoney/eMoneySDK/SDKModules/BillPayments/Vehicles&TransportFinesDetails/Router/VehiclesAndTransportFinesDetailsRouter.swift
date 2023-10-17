//
//  VehiclesAndTransportFinesDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class VehiclesAndTransportFinesDetailsRouter {
    
    enum Route {
        case fineDetail(dataSource: [StandardCellModel], actions: [BaseButton])
        case walletAmountDetail
        case paymentSuccess(input:BillAccountDetailsParameters?)
        case checkout(input:BillAccountDetailsParameters?)
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(input:BillAccountDetailsParameters?, fineDetails:FinePayBillsResponse?) -> VehiclesAndTransportFinesDetailsViewController {
        let viewController = VehiclesAndTransportFinesDetailsViewController.instantiate(fromAppStoryboard: .VehiclesAndTransportFinesDetails)
        let presenter = VehiclesAndTransportFinesDetailsPresenter()
        let router = VehiclesAndTransportFinesDetailsRouter()
        let interactor = VehiclesAndTransportFinesDetailsInteractor()
        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.input = input
        presenter.fineDetails = fineDetails
        router.view = viewController
        interactor.output = presenter
        return viewController
    }
}

extension VehiclesAndTransportFinesDetailsRouter: VehiclesAndTransportFinesDetailsRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .fineDetail(let dataSource,let actions):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
            
        case .walletAmountDetail:
            
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = FineDetailRouter.setupModule()
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .paymentSuccess(let input):
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillPaymentSuccessRouter.setupModule(viewData: nil,input: input, hideAutoSave: true)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        case .checkout(input: let input):
            self.view?.dismiss(animated: true, completion: {
                if let topVC = UIApplication.getTopViewController() as? BaseViewController {
                    let vc = BillPaymentCheckoutRouter.setupModule(input: input)
                    vc.hidesBottomBarWhenPushed = true
                    topVC.navigationController?.pushViewController(vc, animated: true)
                }
            })
        }
    }
}
