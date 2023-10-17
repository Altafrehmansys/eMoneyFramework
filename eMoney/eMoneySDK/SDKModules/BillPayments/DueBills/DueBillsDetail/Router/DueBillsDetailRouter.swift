//
//  DueBillsDetailRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//  
//

import Foundation
import UIKit

class DueBillsDetailRouter {

    enum Route {
        case billPaymentSuccess
        case addPromo(input:GenericBottomSheetRouter.RouterInput? = nil)
        case showPromoApplied(input:GenericBottomSheetRouter.RouterInput? = nil)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> DueBillsDetailViewController {
        let viewController = DueBillsDetailViewController.instantiate(fromAppStoryboard: .DueBillsDetail)
        let presenter = DueBillsDetailPresenter()
        let router = DueBillsDetailRouter()
        let interactor = DueBillsDetailInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension DueBillsDetailRouter: DueBillsDetailRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .billPaymentSuccess:
            
            let vc = BillPaymentSuccessRouter.setupModule(viewData: nil,input: nil)
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
