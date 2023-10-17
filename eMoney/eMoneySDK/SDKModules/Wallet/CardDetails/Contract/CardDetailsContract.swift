//
//  CardDetailsContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 10/07/2023.
//  
//

import Foundation

protocol CardDetailsViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
}

protocol CardDetailsPresenterProtocol: ViperPresenter {
    var dataSource:[StandardCellModel] {get}
    func loadData()
    func navigateToManageCard()
}

protocol CardDetailsInteractorProtocol: ViperInteractor {
    
}

protocol CardDetailsInteractorOutputProtocol: AnyObject {
}

protocol CardDetailsRouterProtocol: ViperRouter {
    func go(to route: CardDetailsRouter.Route)
}
