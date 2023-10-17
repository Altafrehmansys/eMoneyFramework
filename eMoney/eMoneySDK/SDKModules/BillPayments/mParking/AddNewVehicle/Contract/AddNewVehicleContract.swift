//
//  AddNewVehicleContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//  
//

import Foundation

protocol AddNewVehicleViewProtocol: ViperView {
    
    var presenter: AddNewVehiclePresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol AddNewVehiclePresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel]? { get }
    var actions: [BaseButton]? { get }
    func loadData()
    func dismissView()
  //  func addVehicleTapped()

}

protocol AddNewVehicleInteractorProtocol: ViperInteractor {
    func addVehicle(data: AddVehicleRequestModel)

}

protocol AddNewVehicleInteractorOutputProtocol: AnyObject {
    func didSuccess(data: AddNewVehicleResponseModel)
    func didFail(error: AppError)
}

protocol AddNewVehicleRouterProtocol: ViperRouter {
    func go(to route: AddNewVehicleRouter.Route)
}
