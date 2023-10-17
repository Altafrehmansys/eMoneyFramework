//
//  BillPaymentSuccessContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation

protocol BillPaymentSuccessViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
    func update(amount: String, currency: String)
    func showCompleteRecharge()

}

protocol BillPaymentSuccessPresenterProtocol: ViperPresenter {
    var datasource:[StandardCellModel] {get}
    var hideAutoSave:Bool {get}
    var input:BillAccountDetailsParameters? {get set}
    func loadData()
    func completeRechargeTapped()
}

protocol BillPaymentSuccessInteractorProtocol: ViperInteractor {
    func getTransactionData(id: String)
}

protocol BillPaymentSuccessInteractorOutputProtocol: AnyObject {
    func didSuccessTransactionWith(data: BillPaymentSuccessResponseData)
    func didFailTransactionWith(error: AppError)
}

protocol BillPaymentSuccessRouterProtocol: ViperRouter {
    func go(to route: BillPaymentSuccessRouter.Route)
}
