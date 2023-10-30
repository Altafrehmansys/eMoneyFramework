//
//  OtpForgotPinPopupContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

protocol OtpForgotPinPopupViewProtocol: ViperView {
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func forgetPinOtpSendError(error: AppError)
}

protocol OtpForgotPinPopupPresenterProtocol: ViperPresenter {

    func checkotpSendRequestResponse()
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel)
    func navigateSetPin()
    func getTokenRequestFromServer()
    func dismissView()
}

protocol OtpForgotPinPopupInteractorProtocol: ViperInteractor {
    func checkForgetPinOtpSendRequestResponseFromServer()
    func getTokenRequestFromServer()
}

protocol OtpForgotPinPopupInteractorOutputProtocol: AnyObject {
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func forgetPinOtpSendRequestError(error: AppError)
    func getTokenRequestResponse()
}

protocol OtpForgotPinPopupRouterProtocol: ViperRouter {
    func go(to route: OtpForgotPinPopupRouter.Route)
}

protocol OtpForgotPinPopupDelegate {
    func otpPopupDidDismiss()
}
