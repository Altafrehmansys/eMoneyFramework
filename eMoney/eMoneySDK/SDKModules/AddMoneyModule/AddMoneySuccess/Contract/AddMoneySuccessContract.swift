//
//  AddMoneySuccessContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation

protocol AddMoneySuccessViewProtocol: ViperView {
    var presenter: AddMoneySuccessPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol AddMoneySuccessPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get set }
    var isCollapsed: Bool { get set }
    
    var title: String { get set}
    var subtitle: String { get set}
    var switchTitle: String { get set}
    var amount: String { get set}
    var transactionID: String { get set}

    func loadData()
    func makeDataSource()
    
    // Actions
    func shareButtonAction()
    func backAction()
}

protocol AddMoneySuccessInteractorProtocol: ViperInteractor {
    
}

protocol AddMoneySuccessInteractorOutputProtocol: AnyObject {
}

protocol AddMoneySuccessRouterProtocol: ViperRouter {
    func go(to route: AddMoneySuccessRouter.Route)
}
