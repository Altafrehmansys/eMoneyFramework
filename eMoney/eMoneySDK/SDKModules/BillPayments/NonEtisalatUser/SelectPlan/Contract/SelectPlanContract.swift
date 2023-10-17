//
//  SelectPlanContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 25/05/2023.
//  
//

import Foundation

protocol SelectPlanViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
}

protocol SelectPlanPresenterProtocol: ViperPresenter {
    var dataSource:[StandardCellModel] {get}
    func loadData()
    func navigateToBillPaymentCheckout()
    var input:BillAccountDetailsParameters? {get}
}

protocol SelectPlanInteractorProtocol: ViperInteractor {
    
}

protocol SelectPlanInteractorOutputProtocol: AnyObject {
}

protocol SelectPlanRouterProtocol: ViperRouter {
    func go(to route: SelectPlanRouter.Route)
}
