//
//  BillAccountDetailsInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation

class BillAccountDetailsInteractor {
    // MARK: Properties

    weak var output: BillAccountDetailsInteractorOutputProtocol?

}

extension BillAccountDetailsInteractor: BillAccountDetailsInteractorProtocol {
    //Implement your services
    
    func validate(msisdn: String, accountNumber: String, serviceId: String, pinNumber: String?) {
        Task{
            do {
                let response: ValidatePayBillResponse? = try await ApiManager.shared.execute(CommonAPIRouter.validatePhone(phoneNumber: msisdn, accountNumber: accountNumber, serviceId: serviceId, pinNumber: pinNumber))
                await MainActor.run {
                    guard let response = response else { return }
                    output?.validatePhoneNumberSuccess(data: response)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.validatePhoneNumberFail(error: error)
                }
            }
        }
    }
}
