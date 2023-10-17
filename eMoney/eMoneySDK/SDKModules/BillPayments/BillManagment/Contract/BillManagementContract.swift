//
//  BillManagementContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

protocol BillManagementViewProtocol: ViperView {
    
    var presenter: BillManagementPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol BillManagementPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    
    func editAccountDetails()
    func deleteBiller()
    func downloadStatement()
}

protocol BillManagementInteractorProtocol: ViperInteractor {
    
}

protocol BillManagementInteractorOutputProtocol: AnyObject {
}

protocol BillManagementRouterProtocol: ViperRouter {
    func go(to route: BillManagementRouter.Route)
}
