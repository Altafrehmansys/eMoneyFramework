//
//  FineDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

protocol FineDetailViewProtocol: ViperView {
    
    var presenter: FineDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol FineDetailPresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToSuccessfulScreen()
}

protocol FineDetailInteractorProtocol: ViperInteractor {
    
}

protocol FineDetailInteractorOutputProtocol: AnyObject {
}

protocol FineDetailRouterProtocol: ViperRouter {
    func go(to route: FineDetailRouter.Route)
}
