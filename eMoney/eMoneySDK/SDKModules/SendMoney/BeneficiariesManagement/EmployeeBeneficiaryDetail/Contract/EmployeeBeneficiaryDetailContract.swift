//
//  EmployeeBeneficiaryDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation

protocol EmployeeBeneficiaryDetailViewProtocol: ViperView {
   
    var presenter: EmployeeBeneficiaryDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol EmployeeBeneficiaryDetailPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
}

protocol EmployeeBeneficiaryDetailInteractorProtocol: ViperInteractor {
    
}

protocol EmployeeBeneficiaryDetailInteractorOutputProtocol: AnyObject {
}

protocol EmployeeBeneficiaryDetailRouterProtocol: ViperRouter {
    func go(to route: EmployeeBeneficiaryDetailRouter.Route)
}
