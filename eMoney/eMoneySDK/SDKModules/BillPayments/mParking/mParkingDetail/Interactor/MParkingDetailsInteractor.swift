//
//  MParkingDetailsInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

class MParkingDetailsInteractor {
    // MARK: Properties

    weak var output: MParkingDetailsInteractorOutputProtocol?

}

extension MParkingDetailsInteractor: MParkingDetailsInteractorProtocol {
    func getSMSDetails() {
        Task{
            do {
                let response: ParkingSMSCopyResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getSMSDetails)
                await MainActor.run {
                    output?.onGetSMSDetails(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onGetSMSDetails(Error: error)
                }
            }
        }
    }
    func getRegionList(_ listType: String) {
        Task{
            do {
                let response: MParkingDetailsRegionResponseeModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getResourceList(listType))
                await MainActor.run {
                    output?.onGetRegionList(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onGetRegionList(Error: error)
                }
            }
        }
    }
    
    func getZoneList() {
        Task{
            do {
                let response: MParkingDetailsZoneResponseeModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getParkingZones)
                await MainActor.run {
                    output?.onGetZoneList(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onGetZoneList(Error: error)
                }
            }
        }
    }
    func addParking(_ parking:ParkingRequestModel) {
        Task{
            do {
                let response: AddParkingResponseeModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.addParking(parking))
                await MainActor.run {
                    output?.onAddParking(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onAddParking(Error: error)
                }
            }
        }
    }
    
    
    //Implement your services
}
