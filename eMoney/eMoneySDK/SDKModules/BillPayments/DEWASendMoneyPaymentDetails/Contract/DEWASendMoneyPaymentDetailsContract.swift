//
//  DEWASendMoneyPaymentDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation

protocol DEWASendMoneyPaymentDetailsViewProtocol: ViperView {
    
    var presenter: DEWASendMoneyPaymentDetailsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
}

protocol DEWASendMoneyPaymentDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToNextScreen()
}

protocol DEWASendMoneyPaymentDetailsInteractorProtocol: ViperInteractor {
    
}

protocol DEWASendMoneyPaymentDetailsInteractorOutputProtocol: AnyObject {
}

protocol DEWASendMoneyPaymentDetailsRouterProtocol: ViperRouter {
    func go(to route: DEWASendMoneyPaymentDetailsRouter.Route)
}
