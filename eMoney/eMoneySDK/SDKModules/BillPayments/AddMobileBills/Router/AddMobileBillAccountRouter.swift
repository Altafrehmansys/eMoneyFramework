//
//  AddMobileBillAccountRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation
import UIKit

class AddMobileBillAccountRouter {

    enum Route {
        case showIdentityVerficationBottomSheet(dataSource: [StandardCellModel])
        case captureIdentity
        case moveToShowMobileAmountScreen
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AddMobileBillAccountViewController {
        let viewController = AddMobileBillAccountViewController.instantiate(fromAppStoryboard: .AddMobileBillAccount)
        let presenter = AddMobileBillAccountPresenter()
        let router = AddMobileBillAccountRouter()
        let interactor = AddMobileBillAccountInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension AddMobileBillAccountRouter: AddMobileBillAccountRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .showIdentityVerficationBottomSheet(let dataSource):
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
            let bottomSheet = GenericBottomSheetRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        case .captureIdentity:
            let vc = CaptureIdentityInfoRouter.setupModule()
            self.view?.navigationController?.pushViewController(vc, animated: true)
            
        case .moveToShowMobileAmountScreen:
            break
//            let vc = AddBillsEnterAmountRouter.setupModule()
//            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
