//
//  MobileBeneficiaryDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation

protocol MobileBeneficiaryDetailViewProtocol: ViperView {
    
    var presenter: MobileBeneficiaryDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol MobileBeneficiaryDetailPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
}

protocol MobileBeneficiaryDetailInteractorProtocol: ViperInteractor {
    
}

protocol MobileBeneficiaryDetailInteractorOutputProtocol: AnyObject {
}

protocol MobileBeneficiaryDetailRouterProtocol: ViperRouter {
    func go(to route: MobileBeneficiaryDetailRouter.Route)
}
