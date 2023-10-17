//
//  ReEnterPinContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation

protocol ReEnterPinViewProtocol: ViperView {
    func resetPinRequestResponse(response: ResetPinResponseModel)
    func onResetRequestError(error:AppError)
}

protocol ReEnterPinPresenterProtocol: ViperPresenter {
    func navigateBackToLogin()
    func navigateSuccess()
    func navigateForgotPinSuccess()
    func callRegistrationApi(pin: String, isBiomatricEnabled:Bool)
    func callResetApi(resetPinObj : ResetPinRequestModel)
    func navigateToNotificationScreen()
}

protocol ReEnterPinInteractorProtocol: ViperInteractor {
    func registerUser(request:RegistrationRequestModel)
    func loginUser(pin : String)
    func callResetApi(request:ResetPinRequestModel)
}

protocol ReEnterPinInteractorOutputProtocol: AnyObject {
    func onRegisterUserResponse(response:RegistrationResponseModel?)
    func onRegisterUserError(error:AppError)
    func loginRequestResponse(response: LoginResponseModel)
    func resetPinResponse(response: ResetPinResponseModel)
    func loginRequestResponseError(error: AppError)
    func onResetError(error:AppError)
}

protocol ReEnterPinRouterProtocol: ViperRouter {
    func go(to route: ReEnterPinRouter.Route)
}
