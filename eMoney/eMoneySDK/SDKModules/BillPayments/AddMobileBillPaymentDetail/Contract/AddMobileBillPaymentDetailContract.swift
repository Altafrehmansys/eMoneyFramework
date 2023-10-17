//
//  AddMobileBillPaymentDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation

protocol AddMobileBillPaymentDetailViewProtocol: ViperView {
    var presenter: AddMobileBillPaymentDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
}

protocol AddMobileBillPaymentDetailPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToSuccessScreen()
}

protocol AddMobileBillPaymentDetailInteractorProtocol: ViperInteractor {
    
}

protocol AddMobileBillPaymentDetailInteractorOutputProtocol: AnyObject {
}

protocol AddMobileBillPaymentDetailRouterProtocol: ViperRouter {
    func go(to route: AddMobileBillPaymentDetailRouter.Route)
}
