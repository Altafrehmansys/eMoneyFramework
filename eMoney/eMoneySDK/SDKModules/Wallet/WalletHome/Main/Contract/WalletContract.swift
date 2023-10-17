//
//  WalletContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation

protocol WalletViewProtocol: ViperView {
    
    var presenter: WalletPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
    
}

protocol WalletPresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func eAndMoneyAccountsDataSource()
    func savedAccountsDataSource()
    func loadCardBottomSheetView()
    func loadBankBottomSheetView()
    func navigateToCardDetails()
    
}

protocol WalletInteractorProtocol: ViperInteractor {
    func getBankAccounts()
    func getCards()
}

protocol WalletInteractorOutputProtocol: AnyObject {
}

protocol WalletRouterProtocol: ViperRouter {
    func go(to route: WalletRouter.Route)
}
