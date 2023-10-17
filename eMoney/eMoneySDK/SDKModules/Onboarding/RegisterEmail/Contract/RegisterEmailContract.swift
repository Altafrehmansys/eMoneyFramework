//
//  RegisterEmailContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation

protocol RegisterEmailViewProtocol: ViperView {
    func verifyEmailError(error: AppError)
}

protocol RegisterEmailPresenterProtocol: ViperPresenter {
    func loadData()
    func routeToRegisterPin()
    func callVerifyEmail(email:String)
}

protocol RegisterEmailInteractorProtocol: ViperInteractor {
    func verifyEmail(email: String)
}

protocol RegisterEmailInteractorOutputProtocol: AnyObject {
    func verifyEmailResponse(response: BaseResponseModel?)
    func verifyEmailError(error: AppError)
}

protocol RegisterEmailRouterProtocol: ViperRouter {
    func go(to route: RegisterEmailRouter.Route)
}
