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
    var flowName: FlowNames?
}

extension OtpPopupPresenter: OtpPopupPresenterProtocol {
    func checkotpSendRequestResponse() {
        Loader.shared.showFullScreen()
        interactor?.checkotpSendRequestResponseFromServer(with: self.flowName)
    }
    
    func verifyOtpRequestResponse(otp: String, flowType: UserJourneyFlow) {
        Loader.shared.showFullScreen()
        interactor?.verifyOtpRequestResponseFromServer(with: otp, and: self.flowName)
    }
    
    func initiatePinRequest(resend: Bool, questionSkip: Bool, unblock: Bool) {
        interactor?.initiatePinRequestFromServer(resend: resend, isQuestionSkip: questionSkip, isUnblockFlow: unblock)
    }
    
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel) {
        router?.go(to: .failedOtp(model: model))
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
}
