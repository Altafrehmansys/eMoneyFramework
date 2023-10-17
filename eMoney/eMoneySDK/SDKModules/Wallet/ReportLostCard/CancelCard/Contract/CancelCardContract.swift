//
//  CancelCardContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation

protocol CancelCardViewProtocol: ViperView {
    
}

protocol CancelCardPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol CancelCardInteractorProtocol: ViperInteractor {
    
}

protocol CancelCardInteractorOutputProtocol: AnyObject {
}

protocol CancelCardRouterProtocol: ViperRouter {
    func go(to route: CancelCardRouter.Route)
}
