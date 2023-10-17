//
//  BillPaymentCheckoutRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation
import UIKit

class BillPaymentCheckoutRouter {
    
    enum Route {
        case billPaymentSuccess(data: BillPaymentSuccessViewData,input:BillAccountDetailsParameters?)
        case addPromo(input:GenericBottomSheetRouter.RouterInput? = nil)
        case showPromoApplied(input:GenericBottomSheetRouter.RouterInput? = nil)
    }
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(input:BillAccountDetailsParameters?) -> BillPaymentCheckoutViewController {
        let viewController = BillPaymentCheckoutViewController.instantiate(fromAppStoryboard: .BillPaymentCheckout)
        let presenter = BillPaymentCheckoutPresenter()
        let router = BillPaymentCheckoutRouter()
        let interactor = BillPaymentCheckoutInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.billInput = input
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}

extension BillPaymentCheckoutRouter: BillPaymentCheckoutRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case let .billPaymentSuccess(data,input):
            let vc = BillPaymentSuccessRouter.setupModule(viewData: data,input: input)
            vc.modalPresentationStyle = .fullScreen
            self.view?.navigationController?.present(vc, animated: true)
            
        case let .addPromo(input):
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            self.view?.navigationController?.present(vc, animated: true)
        case let .showPromoApplied(input):
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            self.view?.navigationController?.present(vc, animated: true)

        }
    }
}
