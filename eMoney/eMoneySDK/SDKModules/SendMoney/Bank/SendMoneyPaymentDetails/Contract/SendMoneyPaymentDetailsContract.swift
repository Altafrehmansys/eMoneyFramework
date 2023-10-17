//
//  SendMoneyPaymentDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation

protocol SendMoneyPaymentDetailsViewProtocol: ViperView {
    
    var presenter: SendMoneyPaymentDetailsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
}

protocol SendMoneyPaymentDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToNextScreen()
}

protocol SendMoneyPaymentDetailsInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneyPaymentDetailsInteractorOutputProtocol: AnyObject {
}

protocol SendMoneyPaymentDetailsRouterProtocol: ViperRouter {
    func go(to route: SendMoneyPaymentDetailsRouter.Route)
}
