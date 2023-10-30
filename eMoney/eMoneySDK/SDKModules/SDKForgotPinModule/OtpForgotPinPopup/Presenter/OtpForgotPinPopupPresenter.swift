//
//  OtpPopupPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

class OtpForgotPinPopupPresenter {
    weak var view: OtpForgotPinPopupViewProtocol?
    var router: OtpForgotPinPopupRouterProtocol?
    var interactor: OtpForgotPinPopupInteractorProtocol?
}

extension OtpForgotPinPopupPresenter: OtpForgotPinPopupPresenterProtocol {
    func checkotpSendRequestResponse() {
        Loader.shared.showFullScreen()
        interactor?.checkForgetPinOtpSendRequestResponseFromServer()
    }
    
    func getTokenRequestFromServer() {
        Loader.shared.showFullScreen()
        interactor?.getTokenRequestFromServer()
    }
    
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel) {
        router?.go(to: .failedOtp(model: model))
    }
    
    func navigateSetPin() {
        router?.go(to: .newPin)
    }
    
    func dismissView() {
        router?.go(to: .dismiss)
    }
}

extension OtpForgotPinPopupPresenter: OtpForgotPinPopupInteractorOutputProtocol {
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        view?.forgetPinOtpSendRequestResponse(response: response)
    }
    
    func forgetPinOtpSendRequestError(error: AppError) {
        view?.forgetPinOtpSendError(error: error)
    }
    
    func getTokenRequestResponse() {
        interactor?.checkForgetPinOtpSendRequestResponseFromServer()
    }
}
