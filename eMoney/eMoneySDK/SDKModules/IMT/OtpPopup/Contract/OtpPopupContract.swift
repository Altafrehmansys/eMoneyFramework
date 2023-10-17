//
//  OtpPopupContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

protocol OtpPopupViewProtocol: ViperView {
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func otpSendError(error: AppError)
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel)
    func initiatePinRequestResponse(response: InitiatePinResponseModel)
    func verifyMobileRequestResponseError(error: AppError)
}

protocol OtpPopupPresenterProtocol: ViperPresenter {
    
    var msisdn: String { get set }
    var addingText: String { get set }
    var amount: String { get set }
    var toTitle: String { get set }

    func checkotpSendRequestResponse()
    func verifyOtpRequestResponse(otp : String,flowType : UserJourneyFlow)
    func initiatePinRequest(resend:Bool, questionSkip : Bool,unblock : Bool)
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel)
}

protocol OtpPopupInteractorProtocol: ViperInteractor {
    func checkotpSendRequestResponseFromServer(with flowName: FlowNames?)
    func verifyOtpRequestResponseFromServer(with otp: String, and flowName: FlowNames?)
    func initiatePinRequestFromServer(resend: Bool, isQuestionSkip: Bool, isUnblockFlow: Bool)
}

protocol OtpPopupInteractorOutputProtocol: AnyObject {
    
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel)
    func otpSendRequestError(error: AppError)
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel)
    func initiatePinRequestResponse(response: InitiatePinResponseModel)
    func verifyMobileRequestResponseError(error: AppError)
}

protocol OtpPopupRouterProtocol: ViperRouter {
    func go(to route: OtpPopupRouter.Route)
}

protocol OtpPopupDelegate {
    func otpPopupDidDismiss()
}
