//
//  SenderDetailContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol SenderDetailViewProtocol: ViperView {
    func setupUI()
    func reloadData()
}

protocol SenderDetailPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource()
}

protocol SenderDetailInteractorProtocol: ViperInteractor {
    
}

protocol SenderDetailInteractorOutputProtocol: AnyObject {
}

protocol SenderDetailRouterProtocol: ViperRouter {
    func go(to route: SenderDetailRouter.Route)
}
