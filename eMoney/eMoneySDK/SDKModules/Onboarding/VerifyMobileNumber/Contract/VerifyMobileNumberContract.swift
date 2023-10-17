//
//  VerifyMobileNumberContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

protocol VerifyMobileNumberViewProtocol: ViperView {
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func otpSendError(error: AppError)
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel)
    func initiatePinRequestResponse(response: VerifyMobileNumberResponseModel)
    func verifyMobileRequestResponseError(error: AppError)
}

protocol VerifyMobileNumberPresenterProtocol: ViperPresenter {
    func checkotpSendRequestResponse()
    func verifyOtpRequestResponse(otp : String,flowType : UserJourneyFlow)
    func navigateToSelectMethod()
    func navigateToRegisterPin(otp:String)
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel)
    func initiatePinRequest(resend:Bool, questionSkip : Bool,unblock : Bool)
}

protocol VerifyMobileNumberInteractorProtocol: ViperInteractor {
    func checkotpSendRequestResponseFromServer()
    func verifyOtpRequestResponseFromServer(otp:String)
    func initiatePinRequestFromServer(resend: Bool, isQuestionSkip: Bool, isUnblockFlow: Bool)
}

protocol VerifyMobileNumberInteractorOutputProtocol: AnyObject {
    
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func otpSendRequestError(error: AppError)
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel)
    func initiatePinRequestResponse(response: VerifyMobileNumberResponseModel)
    func verifyMobileRequestResponseError(error: AppError)
}

protocol VerifyMobileNumberRouterProtocol: ViperRouter {
    func go(to route: VerifyMobileNumberRouter.Route)
}
