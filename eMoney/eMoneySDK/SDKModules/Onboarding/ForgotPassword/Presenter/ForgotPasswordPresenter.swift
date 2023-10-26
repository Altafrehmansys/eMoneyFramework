//
//  ForgotPasswordPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 15/06/2023.
//  
//

import Foundation

class ForgotPasswordPresenter {

    // MARK: Properties

    weak var view: ForgotPasswordViewProtocol?
    var router: ForgotPasswordRouterProtocol?
    var interactor: ForgotPasswordInteractorProtocol?
}

extension ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    
    func loadData() {
        
    }
    func backToLogin(){
        router?.go(to: .backToLogin)
    }
}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutputProtocol {
    
}
