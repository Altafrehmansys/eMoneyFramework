//
//  BillsAndTopsUpInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

class BillsAndTopsUpInteractor {
    // MARK: Properties

    weak var output: BillsAndTopsUpInteractorOutputProtocol?

}

extension BillsAndTopsUpInteractor: BillsAndTopsUpInteractorProtocol {
    func getBillsList() {
        Task{
            do {
                let response: BillsAndTopsUpResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getBillTypes)
                await MainActor.run {
                    output?.onAllBillsList(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onAllBillsList(Error: error)
                }
            }
        }
    }
    
    func getSavedBills() {
        Task{
            do {
                let response: BillsAndTopsUpResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.savedBills)
                await MainActor.run {
                    output?.onSavedBillsList(Response:response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.onSavedBillsList(Error: error)
                }
            }
        }
    }
}
