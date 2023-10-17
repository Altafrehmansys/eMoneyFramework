//
//  DueBillsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation

protocol DueBillsViewProtocol: ViperView {
    
    var presenter: DueBillsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    func setBillsCount(_ count:Int)
}

protocol DueBillsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    
    func moveToDueBillsDetailsScreen()

}

protocol DueBillsInteractorProtocol: ViperInteractor {
    
}

protocol DueBillsInteractorOutputProtocol: AnyObject {
}

protocol DueBillsRouterProtocol: ViperRouter {
    func go(to route: DueBillsRouter.Route)
}
