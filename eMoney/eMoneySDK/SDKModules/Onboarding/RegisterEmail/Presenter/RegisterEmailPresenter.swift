//
//  RegisterEmailPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation

class RegisterEmailPresenter {

    // MARK: Properties

    weak var view: RegisterEmailViewProtocol?
    var router: RegisterEmailRouterProtocol?
    var interactor: RegisterEmailInteractorProtocol?
}

extension RegisterEmailPresenter: RegisterEmailPresenterProtocol {
    
    func loadData() {
        
    }
    func routeToRegisterPin() {
        router?.go(to: .registerPin)
    }
    func callVerifyEmail(email: String) {
        GlobalData.shared.userEmail = email
        Loader.shared.showFullScreen()
        interactor?.verifyEmail(email: email)
    }
}

extension RegisterEmailPresenter: RegisterEmailInteractorOutputProtocol {
    func verifyEmailResponse(response: BaseResponseModel?) {
        Loader.shared.hideFullScreen()
        routeToRegisterPin()
    }
    
    func verifyEmailError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.verifyEmailError(error: error)
    }
    
    
}
