//
//  BillPaymentCheckoutContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

protocol BillPaymentCheckoutViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
    func updatePayBtn(fees: String)
}

protocol BillPaymentCheckoutPresenterProtocol: ViperPresenter {
    var datasource:[StandardCellModel] {get}
    var billInput:BillAccountDetailsParameters? {get set}
    func loadData()
    func navigateToSuccess()
    func presentAddPromo()
}

protocol BillPaymentCheckoutInteractorProtocol: ViperInteractor {
    func submitPayment(data: BillPaymentCheckoutRequest)
    func submitPaymentiInternational(data: BillPaymentCheckoutRequest) 
}

protocol BillPaymentCheckoutInteractorOutputProtocol: AnyObject {
    func didSuccessSubmitPayment(data: BillPaymentCheckoutResponseModel)
    func didFailedSubmitPayment(error: AppError)
    func didSuccessSubmitInternationalPayment(data: BillPaymentCheckoutResponseModel)

}

protocol BillPaymentCheckoutRouterProtocol: ViperRouter {
    func go(to route: BillPaymentCheckoutRouter.Route)
}
