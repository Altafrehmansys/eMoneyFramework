//
//  RecentParkingInteractor.swift
//  e&money
//
//  Created by Usama Zahid Khan on 15/06/2023.
//  
//

import Foundation

class RecentParkingInteractor {
    // MARK: Properties

    weak var output: RecentParkingInteractorOutputProtocol?

}

extension RecentParkingInteractor: RecentParkingInteractorProtocol {
    func getRecentParkings() {
        Task{
            do {
                let response: RecentParkingResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getRecentParkings)
                await MainActor.run {
                    guard let response = response else { return }
                    output?.onRecentParkingSuccess(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onRecentParkingSuccess(error: error)
                }
            }
        }
    }
    
    func getVehciles(data: BillRequestModel) {
        Task{
            do {
                let response: BillResponse? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getBills(data: data))
                await MainActor.run {
                    guard let response = response else { return }
                    output?.onGetVehicleSuccess(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onGetVehiclesFail(error: error)
                }
            }
        }
    }
    
    func addVehcile() {
        Task{
            do {
                let response: RecentParkingResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getRecentParkings)
                await MainActor.run {
                    guard let response = response else { return }
                    output?.onRecentParkingSuccess(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onRecentParkingSuccess(error: error)
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
}
