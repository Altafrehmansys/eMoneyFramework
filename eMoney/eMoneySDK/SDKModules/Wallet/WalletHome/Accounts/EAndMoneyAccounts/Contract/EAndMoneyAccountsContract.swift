//
//  EAndMoneyAccountsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation

protocol EAndMoneyAccountsViewProtocol: ViperView {
    
    var presenter: EAndMoneyAccountsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol EAndMoneyAccountsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
}

protocol EAndMoneyAccountsInteractorProtocol: ViperInteractor {
    
}

protocol EAndMoneyAccountsInteractorOutputProtocol: AnyObject {
}

protocol EAndMoneyAccountsRouterProtocol: ViperRouter {
    func go(to route: EAndMoneyAccountsRouter.Route)
}
