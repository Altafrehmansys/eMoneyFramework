//
//  TransferStatusContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol TransferStatusViewProtocol: ViperView {
    func setupUI()
    func reloadData()
}

protocol TransferStatusPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource()
}

protocol TransferStatusInteractorProtocol: ViperInteractor {
    
}

protocol TransferStatusInteractorOutputProtocol: AnyObject {
}

protocol TransferStatusRouterProtocol: ViperRouter {
    func go(to route: TransferStatusRouter.Route)
}
