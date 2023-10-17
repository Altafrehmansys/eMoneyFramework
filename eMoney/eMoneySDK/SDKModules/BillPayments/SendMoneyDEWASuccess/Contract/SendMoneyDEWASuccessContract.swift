//
//  SendMoneyDEWASuccessContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation

protocol SendMoneyDEWASuccessViewProtocol: ViperView {
    
    var presenter: SendMoneyDEWASuccessPresenterProtocol! { get set }
    func setUpUI()
    func reloadData()
    
}

protocol SendMoneyDEWASuccessPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get set }
    var isCollapsed: Bool { get set }
    func loadData()
    func makeDataSource()
    
    func moveToHomeScreen()
}

protocol SendMoneyDEWASuccessInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneyDEWASuccessInteractorOutputProtocol: AnyObject {
}

protocol SendMoneyDEWASuccessRouterProtocol: ViperRouter {
    func go(to route: SendMoneyDEWASuccessRouter.Route)
}
