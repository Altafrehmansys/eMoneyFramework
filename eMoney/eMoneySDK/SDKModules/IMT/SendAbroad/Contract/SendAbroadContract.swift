//
//  SendAbroadContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation

protocol SendAbroadViewProtocol: ViperView {
    func setupUI()
    func reloadData()
}

protocol SendAbroadPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource()
    func routeToExchangeAlert()
    func startTransfer()
}

protocol SendAbroadInteractorProtocol: ViperInteractor {
    
}

protocol SendAbroadInteractorOutputProtocol: AnyObject {
}

protocol SendAbroadRouterProtocol: ViperRouter {
    func go(to route: SendAbroadRouter.Route)
}
