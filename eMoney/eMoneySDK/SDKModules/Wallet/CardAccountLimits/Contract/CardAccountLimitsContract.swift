//
//  CardAccountLimitsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//  
//

import Foundation

protocol CardAccountLimitsViewProtocol: ViperView {
    
    var presenter: CardAccountLimitsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol CardAccountLimitsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
}

protocol CardAccountLimitsInteractorProtocol: ViperInteractor {
    
}

protocol CardAccountLimitsInteractorOutputProtocol: AnyObject {
}

protocol CardAccountLimitsRouterProtocol: ViperRouter {
    func go(to route: CardAccountLimitsRouter.Route)
}
