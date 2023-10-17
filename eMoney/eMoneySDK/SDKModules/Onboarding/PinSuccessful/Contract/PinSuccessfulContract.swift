//
//  PinSuccessfulContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation

protocol PinSuccessfulViewProtocol: ViperView {
    
}

protocol PinSuccessfulPresenterProtocol: ViperPresenter {
    func loadData()
    func moveToLoginView()
}

protocol PinSuccessfulInteractorProtocol: ViperInteractor {
    
}

protocol PinSuccessfulInteractorOutputProtocol: AnyObject {
}

protocol PinSuccessfulRouterProtocol: ViperRouter {
    func go(to route: PinSuccessfulRouter.Route)
}
