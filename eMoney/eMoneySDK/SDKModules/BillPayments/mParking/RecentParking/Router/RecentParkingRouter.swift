//
//  RecentParkingRouter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation
import UIKit

class RecentParkingRouter {

    enum Route {
        case addNewVehicle(dataSource: [StandardCellModel], actions: [BaseButton])
        case vehicleMParking(navTitle:String,selectedItem:ListItems?)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle: String, selecteItem: ListItems?, billType: BillsAnsTopUpType) -> RecentParkingViewController {
        let viewController = RecentParkingViewController.instantiate(fromAppStoryboard: .RecentParking)
        let presenter = RecentParkingPresenter()
        let router = RecentParkingRouter()
        let interactor = RecentParkingInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.navTitle = navTitle
        presenter.selectedItem = selecteItem
        presenter.selectItemType = billType
        
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension RecentParkingRouter: RecentParkingRouterProtocol {
    // Implement Routing methods
    
    func go(to route: Route) {
        switch route {
        case .addNewVehicle(let dataSource, let actions):
            let input = AddNewVehicleRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = AddNewVehicleRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        case .vehicleMParking(let navTitle,let selectedItem):
            let vc = MParkingDetailsRouter.setupModule(navTitle: navTitle, selecteItem: selectedItem, billType: .vehiclemParking)
            vc.hidesBottomBarWhenPushed = true
            self.view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
