//
//  AddNewVehicleInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//  
//

import Foundation

class AddNewVehicleInteractor {
    // MARK: Properties

    weak var output: AddNewVehicleInteractorOutputProtocol?

}

extension AddNewVehicleInteractor: AddNewVehicleInteractorProtocol {
    //Implement your services
    
    func addVehicle(data: AddVehicleRequestModel) {
        Task{
            do {
                let response: AddNewVehicleResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.addBeneficiary(data: data))
                
                await MainActor.run {
                    guard let response = response else { return }
                    output?.didSuccess(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.didFail(error:error)
                }
            }
        }
    }
}


