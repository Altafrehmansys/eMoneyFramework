//
//  ManageSavedAccountsContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/05/2023.
//  
//

import Foundation

protocol ManageSavedAccountsViewProtocol: ViperView {
    var presenter: ManageSavedAccountsPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
    func showRemovedMethodNotificationView(isCard: Bool)
}

protocol ManageSavedAccountsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeDataSource()
}

protocol ManageSavedAccountsInteractorProtocol: ViperInteractor {
    func removeBankAccount(with sourceId: String)
    func removeDebitCard(with card: CardResponseObjectModel.CardResponseObjectDataModel)
}

protocol ManageSavedAccountsInteractorOutputProtocol: AnyObject {
    func onRemoveBankAccount(Response response: BankAccountsListResponseModel?)
    func onRemoveBankAccount(Error error: AppError)
    
    func onDebitCardRemove(Response response: InitializeCardPaymentResponseModel)
    func onDebitCardRemove(Error error: AppError)
}

protocol ManageSavedAccountsRouterProtocol: ViperRouter {
    func go(to route: ManageSavedAccountsRouter.Route)
}
