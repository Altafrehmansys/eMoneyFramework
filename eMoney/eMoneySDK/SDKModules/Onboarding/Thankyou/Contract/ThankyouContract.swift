//
//  ThankyouContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/05/2023.
//  
//

import Foundation

protocol ThankyouViewProtocol: ViperView {
    
}

protocol ThankyouPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToEnterEmail()
    func navigateToHome()
}

protocol ThankyouInteractorProtocol: ViperInteractor {
    
}

protocol ThankyouInteractorOutputProtocol: AnyObject {
}

protocol ThankyouRouterProtocol: ViperRouter {
    func go(to route: ThankyouRouter.Route)
}
