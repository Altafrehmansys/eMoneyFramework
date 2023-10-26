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
    func navigateToSelectMethod() {
        router?.go(to: .captureIdentity)
    }
    func navigateToRegisterPin(otp:String) {
        router?.go(to: .RegisterPin(otp: otp))
    }
    func navigateToFailedOtp(model : VerifyMobileNumberResponseModel) {
        router?.go(to: .failedOtp(model: model))
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
    
    func checkUserStatus() {
        guard let msisdnStatus = GlobalData.shared.msisdnStatusData?.status else {return}
        let status = MsisdnStatus(rawValue: msisdnStatus) ?? .none
        
        switch status {
        case .registered:
//            UserDefaultHelper.msisdn = GlobalData.shared.msisdn
//            router?.go(to: .Login)
//            Alert.showBottomSheetError(title: "account_alreadyregistered".localized, message: "")
            SDKColors.shared.onFailure?("", "account_alreadyregistered".localized)
        case .notExist:
            if GlobalData.shared.isSingleAccount {
                if GlobalData.shared.msisdnStatusData?.eidEnable ?? false {
                    router?.go(to: .captureIdentity)
                }
                else{
                    router?.go(to: .FastTrack)
                }
            } else {
                router?.go(to: .captureIdentity)
            }
        case .activated:
            break
        case .pinReset:
            UserDefaultHelper.msisdn = GlobalData.shared.msisdn
            GlobalData.shared.isDeviceChanged = true
            router?.go(to: .Login)
            SDKColors.shared.onFailure?("", "ONBOARDING_REGISTERED_RESET_PIN")
        case .blocked:
            Alert.showBottomSheetError(title: "your_account_is_blocked".localized, message: "")
            break
        case .suspended:
            Alert.showBottomSheetError(title: "Your account has been suspended", message: "")
            break
        case .none:
            break
        }
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
        switch flowTypeJourney {
        case .onboarding :
            checkUserStatus()
        case .forgotPin :
            router?.go(to: .RegisterPin(otp: ""))
        case .none:
            checkUserStatus()
        }
        
    }
    
    func verifyMobileRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        checkUserStatus()
//        view?.verifyMobileRequestResponseError(error: error)
    }
    
    
}
