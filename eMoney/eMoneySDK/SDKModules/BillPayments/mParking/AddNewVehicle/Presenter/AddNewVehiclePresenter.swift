//
//  AddNewVehiclePresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//  
//

import Foundation

class AddNewVehiclePresenter {

    // MARK: Properties
    weak var view: AddNewVehicleViewProtocol?
    var router: AddNewVehicleRouterProtocol?
    var interactor: AddNewVehicleInteractorProtocol?
    
    var dataSource: [StandardCellModel]?
    var actions: [BaseButton]?
    
}

extension AddNewVehiclePresenter: AddNewVehiclePresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        view?.reloadData()
      //  if let actions = actions
        actions?[1].addTarget(self, action: #selector(addVehicleTapped), for: .touchUpInside)
     //   }

    }
    
    @objc func addVehicleTapped() {
        let data  = AddVehicleRequestModel(region: "region",
                                           plateKind: "Dubai",
                                           plateCode: "N",
                                           plateNumber: "1234")
        interactor?.addVehicle(data: data)
    }
}


// MARK: - Navigations Calls
extension AddNewVehiclePresenter {
    
    
    func dismissView() {
        router?.go(to: .back)
    }
}

extension AddNewVehiclePresenter: AddNewVehicleInteractorOutputProtocol {
    func didSuccess(data: AddNewVehicleResponseModel) {
        
    }
    
    func didFail(error: AppError) {
        
    }
    
                                  
}


