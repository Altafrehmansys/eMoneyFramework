//
//  DeliveryDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

protocol DeliveryDetailsViewProtocol: ViperView {
    func reloadData()
}

protocol DeliveryDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel]  { get set }
    func loadData()
    func didSelectName(index: Int)
    func confirmButtonDidTapped()
}

protocol DeliveryDetailsInteractorProtocol: ViperInteractor {
    
}

protocol DeliveryDetailsInteractorOutputProtocol: AnyObject {
}

protocol DeliveryDetailsRouterProtocol: ViperRouter {
    func go(to route: DeliveryDetailsRouter.Route)
}
