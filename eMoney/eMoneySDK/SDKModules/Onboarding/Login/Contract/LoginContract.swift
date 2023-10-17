//
//  LoginContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

protocol LoginViewProtocol: ViperView {
    func loginResponse(response: LoginResponseModel)
    func loginResponseError(error: AppError)
}

protocol LoginPresenterProtocol: ViperPresenter {
    func naviateToForgotPassword()
    func loginApiCall(pin:String)
}

protocol LoginInteractorProtocol: ViperInteractor {
    func sendLoginPinToServer(pin : String)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginRequestResponse(response: LoginResponseModel)
    func loginRequestResponseError(error: AppError)
}

protocol LoginRouterProtocol: ViperRouter {
    func go(to route: LoginRouter.Route)
}
