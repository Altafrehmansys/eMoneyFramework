//
//  OtpPopupPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

class OtpPopupPresenter {
    weak var view: OtpPopupViewProtocol?
    var router: OtpPopupRouterProtocol?
    var interactor: OtpPopupInteractorProtocol?
        
    var msisdn: String = ""
    var addingText: String = ""
    var amount: String = ""
    var toTitle: String = ""
    var userJourney: UserJourneyFlow?
}

extension OtpPopupPresenter: OtpPopupPresenterProtocol {
    func checkotpSendRequestResponse() {
        Loader.shared.showFullScreen()
        if userJourney == .forgotPin {
            interactor?.checkForgetPinOtpSendRequestResponseFromServer()
        } else {
            interactor?.checkotpSendRequestResponseFromServer()
        }
    }
    
    func verifyOtpRequestResponse(otp: String) {
        Loader.shared.showFullScreen()
        interactor?.verifyOtpRequestResponseFromServer(with: otp)
    }
    
    func initiatePinRequest(resend: Bool, questionSkip: Bool, unblock: Bool) {
        interactor?.initiatePinRequestFromServer(resend: resend, isQuestionSkip: questionSkip, isUnblockFlow: unblock)
    }
    
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel) {
        router?.go(to: .failedOtp(model: model))
    }
    
    func navigateSetPin() {
        router?.go(to: .newPin)
    }
}

extension OtpPopupPresenter: OtpPopupInteractorOutputProtocol {
    func initiatePinRequestResponse(response: InitiatePinResponseModel) {
        view?.initiatePinRequestResponse(response: response)
    }
    
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        view?.otpSendRequestResponse(response: response)
    }
    
    func otpSendRequestError(error: AppError) {
        view?.otpSendError(error: error)
    }
    
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel) {
        view?.otpVerifyRequestResponse(response: response)
    }
    
    func verifyMobileRequestResponseError(error: AppError) {
        view?.verifyMobileRequestResponseError(error: error)
    }
    
    func forgetPinOtpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        view?.forgetPinOtpSendRequestResponse(response: response)
    }
    
    func forgetPinOtpSendRequestError(error: AppError) {
        view?.forgetPinOtpSendError(error: error)
    }
}
