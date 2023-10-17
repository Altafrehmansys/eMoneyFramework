//
//  AllSavedBillsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 24/05/2023.
//  
//

import Foundation

protocol AllSavedBillsViewProtocol: ViperView {
    
    var presenter: AllSavedBillsPresenterProtocol! { get set }
    func setupUI()
    func reloadTableView()
    func reloadCollectionView()
    func setSelectedCellColor(index:Int)
    
}

protocol AllSavedBillsPresenterProtocol: ViperPresenter {
    var tableViewDataSource: [StandardCellModel] { get }
    var collectionViewDataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeTableViewDataSource()
    func makeCollectionDataSource()

}

protocol AllSavedBillsInteractorProtocol: ViperInteractor {
  
}

protocol AllSavedBillsInteractorOutputProtocol: AnyObject {
    
  
    
}

protocol AllSavedBillsRouterProtocol: ViperRouter {
    func go(to route: AllSavedBillsRouter.Route)
}
