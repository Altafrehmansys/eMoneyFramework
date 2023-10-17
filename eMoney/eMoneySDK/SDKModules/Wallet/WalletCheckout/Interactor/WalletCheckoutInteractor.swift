//
//  WalletCheckoutInteractor.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

class WalletCheckoutInteractor {
    // MARK: Properties

    weak var output: WalletCheckoutInteractorOutputProtocol?
    
    

}

extension WalletCheckoutInteractor: WalletCheckoutInteractorProtocol {
    //Implement your services
    
    func submitPayment(data: WalletCheckoutRequest) {
        Task{
//            do {
//                let response: WalletCheckoutResponseModel? = try await ApiManager.shared.execute(BillPaymentAPIRouter.submitBill(data: data) )
//
//                await MainActor.run {
//                    guard let response = response else { return }
//                    output?.didSuccessSubmitPayment(data: response)
//                }
//            } catch let error as AppError {
//                await MainActor.run {
//                    output?.didFailedSubmitPayment(error:error)
//                }
//            }
        }
    }
    
}
