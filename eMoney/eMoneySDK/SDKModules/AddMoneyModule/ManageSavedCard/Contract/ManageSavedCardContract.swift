//
//  ManageSavedCardContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/05/2023.
//  
//

import Foundation

protocol ManageSavedCardViewProtocol: ViperView {
    var presenter: ManageSavedCardPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol ManageSavedCardPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeDataSource()
}

protocol ManageSavedCardInteractorProtocol: ViperInteractor {
    
}

protocol ManageSavedCardInteractorOutputProtocol: AnyObject {
}

protocol ManageSavedCardRouterProtocol: ViperRouter {
    func go(to route: ManageSavedCardRouter.Route)
}
