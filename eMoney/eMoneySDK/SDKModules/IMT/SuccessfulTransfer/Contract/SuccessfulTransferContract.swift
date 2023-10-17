//
//  SuccessfulTransferContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol SuccessfulTransferViewProtocol: ViperView {
    func setupUI()
    func reloadData()
}

protocol SuccessfulTransferPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource(isExpanded : Bool)
    func routeToHomepage()
    func routeToTransferStatus()
    func shareTapped()
}

protocol SuccessfulTransferInteractorProtocol: ViperInteractor {
    
}

protocol SuccessfulTransferInteractorOutputProtocol: AnyObject {
}

protocol SuccessfulTransferRouterProtocol: ViperRouter {
    func go(to route: SuccessfulTransferRouter.Route)
}

