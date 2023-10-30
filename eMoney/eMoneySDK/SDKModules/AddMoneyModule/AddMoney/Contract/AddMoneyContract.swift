//
//  AddMoneyContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation

protocol AddMoneyViewProtocol: ViperView {
    var presenter: AddMoneyPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol AddMoneyPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeDataSource()
    func dismissView()
}

protocol AddMoneyInteractorProtocol: ViperInteractor {
    func getAddMoneyMetaData()
    func getBankAccountsList()
    func getCardsListRequest()
    func initializeAddCard()
    func getAvailableBalance()
}

protocol AddMoneyInteractorOutputProtocol: AnyObject {
    func onBankAccountsList(Response response: BankAccountsListResponseModel?)
    func onBankAccountsList(Error error: AppError)
    
    func onMetaData(Response response: AddMoneyMetaDataResponseModel?)
    func onMetaData(Error error: AppError)
    
    func onCardsList(Response: CardResponseObjectModel)
    func onCardsList(Error error: AppError)
    
    func onAddCard(Response response: AddDebitCardResponseModel)
    func onAddCard(Error error: AppError)
    
    func onAvailableBalanceResponse(response: AvailableBalanceResponse?)
    func onAvailableBalanceError(error: AppError)
}

protocol AddMoneyRouterProtocol: ViperRouter {
    func go(to route: AddMoneyRouter.Route)
}
