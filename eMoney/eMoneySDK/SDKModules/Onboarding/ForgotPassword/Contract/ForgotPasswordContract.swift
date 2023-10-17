//
//  ForgotPasswordContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 15/06/2023.
//  
//

import Foundation

protocol ForgotPasswordViewProtocol: ViperView {
    
}

protocol ForgotPasswordPresenterProtocol: ViperPresenter {
    func loadData()
    func backToLogin()
}

protocol ForgotPasswordInteractorProtocol: ViperInteractor {
    
}

protocol ForgotPasswordInteractorOutputProtocol: AnyObject {
}

protocol ForgotPasswordRouterProtocol: ViperRouter {
    func go(to route: ForgotPasswordRouter.Route)
}
