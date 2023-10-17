//
//  DueBillsDetailContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//  
//

import Foundation

protocol DueBillsDetailViewProtocol: ViperView {
    
    var presenter: DueBillsDetailPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol DueBillsDetailPresenterProtocol: ViperPresenter {
    
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToBillPaymentSuccess()
    
}

protocol DueBillsDetailInteractorProtocol: ViperInteractor {
    
}

protocol DueBillsDetailInteractorOutputProtocol: AnyObject {
}

protocol DueBillsDetailRouterProtocol: ViperRouter {
    func go(to route: DueBillsDetailRouter.Route)
}
