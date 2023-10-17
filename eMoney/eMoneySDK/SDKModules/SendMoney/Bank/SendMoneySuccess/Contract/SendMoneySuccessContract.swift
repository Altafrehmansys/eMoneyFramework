//
//  SendMoneySuccessContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation

protocol SendMoneySuccessViewProtocol: ViperView {
    
    var presenter: SendMoneySuccessPresenterProtocol! { get set }
    func setUpUI()
    func reloadData()
    
}

protocol SendMoneySuccessPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get set }
    var isCollapsed: Bool { get set }
    func loadData()
    func makeDataSource()
    
    func moveToHomeScreen()
}

protocol SendMoneySuccessInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneySuccessInteractorOutputProtocol: AnyObject {
}

protocol SendMoneySuccessRouterProtocol: ViperRouter {
    func go(to route: SendMoneySuccessRouter.Route)
}
