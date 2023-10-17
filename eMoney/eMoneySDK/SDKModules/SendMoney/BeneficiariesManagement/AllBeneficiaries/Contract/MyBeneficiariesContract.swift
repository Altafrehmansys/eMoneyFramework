//
//  MyBeneficiariesContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/05/2023.
//  
//

import Foundation

protocol MyBeneficiariesViewProtocol: ViperView {
    
    var presenter: MyBeneficiariesPresenterProtocol! { get set }
    func setupUI()
    func reloadTableView()
    func reloadCollectionView()
    
    func setSelectedCellColor(index:Int)
    
}

protocol MyBeneficiariesPresenterProtocol: ViperPresenter {
    
    var tableViewDataSource: [StandardCellModel] { get }
    var collectionViewDataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeTableViewDataSource()
    func makeCollectionDataSource()
    
    func navigateToBankBeneficiary()
    func navigateToMobileBeneficiary()
    func navigateToEmployeeBeneficiary()
    
}

protocol MyBeneficiariesInteractorProtocol: ViperInteractor {
    
}

protocol MyBeneficiariesInteractorOutputProtocol: AnyObject {
}

protocol MyBeneficiariesRouterProtocol: ViperRouter {
    func go(to route: MyBeneficiariesRouter.Route)
}
