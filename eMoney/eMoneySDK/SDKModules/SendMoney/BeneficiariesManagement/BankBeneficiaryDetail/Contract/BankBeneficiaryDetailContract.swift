//
//  BankBeneficiaryDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//  
//

import Foundation

protocol BankBeneficiaryDetailViewProtocol: ViperView {
    
    var presenter: BankBeneficiaryDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol BankBeneficiaryDetailPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    
}

protocol BankBeneficiaryDetailInteractorProtocol: ViperInteractor {
    
}

protocol BankBeneficiaryDetailInteractorOutputProtocol: AnyObject {
}

protocol BankBeneficiaryDetailRouterProtocol: ViperRouter {
    func go(to route: BankBeneficiaryDetailRouter.Route)
}
