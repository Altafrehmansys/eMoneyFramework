//
//  AddMoneySelectBankContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 25/04/2023.
//  
//

import Foundation

protocol AddMoneySelectBankViewProtocol: ViperView {
    var presenter: AddMoneySelectBankPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
    func updateBanksList()
}

protocol AddMoneySelectBankPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeDataSource()
}

protocol AddMoneySelectBankInteractorProtocol: ViperInteractor {
    func getBankAccountsList()
}

protocol AddMoneySelectBankInteractorOutputProtocol: AnyObject {
    func onBankAccountsList(Response response: BankAccountsListResponseModel?)
    func onBankAccountsList(Error error: AppError)
}

protocol AddMoneySelectBankRouterProtocol: ViperRouter {
    func go(to route: AddMoneySelectBankRouter.Route)

    func openConnectAccountSDK(customerID: String, bankID: String, paymentDestinationID: String?)
    func openSuccessConnectedAccountScreen()
}
