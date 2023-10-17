//
//  BillSelectPlanContainerViewInteractor.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//  
//

import Foundation

class BillSelectPlanContainerViewInteractor {
    // MARK: Properties

    weak var output: BillSelectPlanContainerViewInteractorOutputProtocol?

}

extension BillSelectPlanContainerViewInteractor: BillSelectPlanContainerViewInteractorProtocol {
    //Implement your services
    func getProducts(accountNumber: String, countryISO: String) {
        Task{
            do {
                let response: ProductsListResponse? = try await ApiManager.shared.execute(BillPaymentAPIRouter.getProducts(accountNumber: accountNumber, countryISO: countryISO))
                await MainActor.run {
                    guard let response = response, let data = response.data else { return }
                    output?.getProductsSuccess(data: data)
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.getProductsFail(error: error)
                }
            }
        }

    }
}
