//
//  MParkingDetailsRouter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation
import UIKit

class MParkingDetailsRouter {

    enum Route {
        case addNewVehicle(dataSource: [StandardCellModel], actions: [BaseButton])
        case addLocationManually
        case presentLocationPermission
        case presentParkingSMSCopy(_ model:ParkingSMSCopyResponseModel)
    }
    
    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(navTitle:String,selecteItem:ListItems?,billType:BillsAnsTopUpType) -> MParkingDetailsViewController {
        let viewController = MParkingDetailsViewController.instantiate(fromAppStoryboard: .MParkingDetails)
        let presenter = MParkingDetailsPresenter()
        let router = MParkingDetailsRouter()
        let interactor = MParkingDetailsInteractor()
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

extension MParkingDetailsRouter: MParkingDetailsRouterProtocol {
    // Implement Routing methods
    func go(to route: Route) {
        switch route {
        case .addNewVehicle(let dataSource, let actions):
            let input = AddNewVehicleRouter.RouterInput(dataSource: dataSource,actionButtons: actions)
            let bottomSheet = AddNewVehicleRouter.setupModule(input: input)
            bottomSheet.modalPresentationStyle = .overCurrentContext
            self.view?.present(bottomSheet, animated: true)
        case .addLocationManually:
            let vc = AddParkingLocationRouter.setupModule()
            self.view?.navigationController?.pushViewController(vc, animated: true)
        case .presentLocationPermission:
            LocationPermissionPrompt.shared.present {
                LocationManager().requestLocationPermission()
            } addManully: {
                let vc = AddParkingLocationRouter.setupModule()
                self.view?.navigationController?.pushViewController(vc, animated: true)
            }
        case .presentParkingSMSCopy(let model):
            let vc = ParkingSMSCopyRouter.setupModule(model)
            self.view?.navigationController?.present(vc, animated: true)
        }
    }
}
