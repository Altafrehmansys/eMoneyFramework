//
//  VehiclesAndTransportDetailInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

class VehiclesAndTransportDetailInteractor {
    // MARK: Properties

    weak var output: VehiclesAndTransportDetailInteractorOutputProtocol?

}

extension VehiclesAndTransportDetailInteractor: VehiclesAndTransportDetailInteractorProtocol {
    func validate(serviceId: String, _ data: [[String : Any]]) {
        Task{
            do {
                let response: VehiclesAndTransportValidateModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.payBill(serviceId:serviceId,data))
                await MainActor.run {
                    output?.onValidatePayBill(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onValidatePayBill(Error: error)
                }
            }
        }
    }
    
    //Implement your services
    func getResourceList(_ listType:String) {
        Task{
            do {
                let response: VehiclesAndTransportResourceModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getResourceList(listType))
                await MainActor.run {
                    output?.ongetResourceList(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.ongetResourceList(Error: error)
                }
            }
        }
    }
    func getLookups(type:String,fieldText:String) {
        Task{
            do {
                let response: VehiclesAndTransportLookupModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getLookups(type:type,fieldText:fieldText))
                await MainActor.run {
                    output?.ongetLookupList(Response:response,type:type)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.ongetResourceList(Error: error)
                }
            }
        }
    }
}
