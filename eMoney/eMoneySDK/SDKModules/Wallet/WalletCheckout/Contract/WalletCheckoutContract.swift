//
//  WalletCheckoutContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import Foundation

protocol WalletCheckoutViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
    func updatePayBtn(fees: String)
}

protocol WalletCheckoutPresenterProtocol: ViperPresenter {
    var datasource:[StandardCellModel] {get}
    var billInput:BillAccountDetailsParameters? {get set}
    func loadData()
    func navigateToSuccess()
    func presentAddPromo()
}

protocol WalletCheckoutInteractorProtocol: ViperInteractor {
    func submitPayment(data: WalletCheckoutRequest)
}

protocol WalletCheckoutInteractorOutputProtocol: AnyObject {
    func didSuccessSubmitPayment(data: WalletCheckoutResponseModel)
    func didFailedSubmitPayment(error: AppError)
    func didSuccessSubmitInternationalPayment(data: WalletCheckoutResponseModel)

}

protocol WalletCheckoutRouterProtocol: ViperRouter {
    func go(to route: WalletCheckoutRouter.Route)
}
