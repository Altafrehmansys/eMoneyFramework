//
//  BillPaymentCheckoutInteractor.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

class BillPaymentCheckoutInteractor {
    // MARK: Properties

    weak var output: BillPaymentCheckoutInteractorOutputProtocol?
    
    

}

extension BillPaymentCheckoutInteractor: BillPaymentCheckoutInteractorProtocol {
    //Implement your services
    
    func submitPayment(data: BillPaymentCheckoutRequest) {
        Task{
            do {
                let response: BillPaymentCheckoutResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.submitBill(data: data) )
                
                await MainActor.run {
                    guard let response = response else { return }
                    output?.didSuccessSubmitPayment(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.didFailedSubmitPayment(error:error)
                }
            }
        }
    }
    
    func submitPaymentiInternational(data: BillPaymentCheckoutRequest) {
        Task{
            do {
                let response: BillPaymentCheckoutResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.submitMobileInternational(data: data) )
                
                await MainActor.run {
                    guard let response = response else { return }
                    output?.didSuccessSubmitInternationalPayment(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.didFailedSubmitPayment(error:error)
                }
            }
        }
    }
}
