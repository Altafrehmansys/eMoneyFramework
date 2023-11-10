//
//  VerifyMobileNumberPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

class VerifyMobileNumberPresenter {

    // MARK: Properties

    weak var view: VerifyMobileNumberViewProtocol?
    var router: VerifyMobileNumberRouterProtocol?
    var interactor: VerifyMobileNumberInteractorProtocol?
    var flowTypeJourney : UserJourneyFlow?
}

extension VerifyMobileNumberPresenter: VerifyMobileNumberPresenterProtocol {
   
    
    func initiatePinRequest(resend: Bool, questionSkip: Bool, unblock: Bool) {
        Loader.shared.showFullScreen()
        interactor?.initiatePinRequestFromServer(resend: resend, isQuestionSkip: questionSkip, isUnblockFlow: unblock)
    }
    
    func navigateToCaptureIdentity(delegate: SendDataSDK?) {
        router?.go(to: .captureIdentity(delegate: delegate))
    }
    
    func navigateToRegisterPin(otp:String) {
        router?.go(to: .RegisterPin(otp: otp))
    }
    
    func navigateToFastTrack() {
        router?.go(to: .FastTrack)
    }
    
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel) {
        router?.go(to: .failedOtp(model: model))
    }
    
    func popToRootView() {
        router?.go(to: .popToRootView)
    }
    
    func checkotpSendRequestResponse() {
        Loader.shared.showFullScreen()
        interactor?.checkotpSendRequestResponseFromServer()
    }

    func verifyOtpRequestResponse(otp: String, flowType: UserJourneyFlow) {
        flowTypeJourney = flowType
//        if (Environment.name == .UAT || Environment.name == .PreProduction) && flowType == .onboarding{
//            checkUserStatus()
//            return
//        }
        Loader.shared.showFullScreen()
        interactor?.verifyOtpRequestResponseFromServer(otp: otp)
    }
}

extension VerifyMobileNumberPresenter: VerifyMobileNumberInteractorOutputProtocol {
    func initiatePinRequestResponse(response: VerifyMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        view?.initiatePinRequestResponse(response: response)
    }
    
    func otpSendRequestResponse(response: VerifyMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        view?.otpSendRequestResponse(response: response)
    }
    
    func otpSendRequestError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.otpSendError(error: error)
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    func otpVerifyRequestResponse(response: VerifyMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        GlobalData.shared.isVerified = true
        view?.otpVerifyRequestResponse(response: response)
    }
    
    func verifyMobileRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.verifyMobileRequestResponseError(error: error)
 
//        view?.verifyMobileRequestResponseError(error: error)
    }
    
    
}
