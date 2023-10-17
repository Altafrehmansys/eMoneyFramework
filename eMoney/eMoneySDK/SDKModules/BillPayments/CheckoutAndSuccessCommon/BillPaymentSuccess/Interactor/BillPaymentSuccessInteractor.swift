//
//  BillPaymentSuccessInteractor.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation

class BillPaymentSuccessInteractor {
    // MARK: Properties

    weak var output: BillPaymentSuccessInteractorOutputProtocol?

}

extension BillPaymentSuccessInteractor: BillPaymentSuccessInteractorProtocol {
    //Implement your services
    
    func getTransactionData(id: String) {
        Task{
            do {
                let response: BillPaymentSuccessResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getTransactionHistory(id: id))
                await MainActor.run {
                    guard let response = response, let data = response.data else { return }
                    output?.didSuccessTransactionWith(data: data)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.didFailTransactionWith(error: error)
                }
            }
        }
    }
}
