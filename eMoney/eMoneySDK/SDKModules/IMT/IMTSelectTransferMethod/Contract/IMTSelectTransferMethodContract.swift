//
//  IMTSelectTransferMethodContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation

protocol IMTSelectTransferMethodViewProtocol: ViperView {
    func reloadData()
}

protocol IMTSelectTransferMethodPresenterProtocol: ViperPresenter {
    func loadData()
    var dataSource: [StandardCellModel] { get }
}

protocol IMTSelectTransferMethodInteractorProtocol: ViperInteractor {
    
}

protocol IMTSelectTransferMethodInteractorOutputProtocol: AnyObject {
}

protocol IMTSelectTransferMethodRouterProtocol: ViperRouter {
    func go(to route: IMTSelectTransferMethodRouter.Route)
}
