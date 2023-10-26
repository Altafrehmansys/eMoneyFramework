//
//  OtpPopupInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

class OtpPopupInteractor {
    // MARK: Properties

    weak var output: OtpPopupInteractorOutputProtocol?

}

extension OtpPopupInteractor: OtpPopupInteractorProtocol {
    //Implement your services
    func initiatePinRequestFromServer(resend: Bool, isQuestionSkip: Bool, isUnblockFlow: Bool) {
        Task {
            do {
                let request = InitiatePinRequestModel(resendFlag: resend, isSecretQuestionSkip: isQuestionSkip, isUnblockFlow: isUnblockFlow)
                let addPostObject:InitiatePinResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.initiatePin(param: request))
                await MainActor.run {
                    if let addPostObject {
                        output?.initiatePinRequestResponse(response: addPostObject)
                    }
                }
                
            } catch let error as AppError {
                await MainActor.run {
                    output?.otpSendRequestError(error: error)
                }
            }
        }
    }
  
    
    func checkotpSendRequestResponseFromServer() {
        Task {
            do {
                let request = VerifyMobileNumberOtpSendRequestModel(isSingleAccount: GlobalData.shared.msisdnStatusData?.isSingleAccount,msisdn: GlobalData.shared.msisdn)
                
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.otpSendToMobile(param: request))
                await MainActor.run {
                    if addPostObject != nil {
                        output?.otpSendRequestResponse(response:addPostObject!)
                    }
                   
                }
                
            } catch let error as AppError {
                await MainActor.run {
                    output?.otpSendRequestError(error: error)
                }
                
            }
        }
    }
    
    func checkForgetPinOtpSendRequestResponseFromServer() {
        Task {
            do {
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.forgetPinSendOtp)
                await MainActor.run {
                    if addPostObject != nil {
                        output?.forgetPinOtpSendRequestResponse(response:addPostObject!)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.forgetPinOtpSendRequestError(error: error)
                }
            }
        }
    }
    
    func verifyOtpRequestResponseFromServer(with otp: String) {
        Task {
            do {
                guard let encryptOtp = try? otp.aesEncrypt(key:EncryptionKey.pinKey) else {return}
                let request = VerifyMobileNumberOtpVerifyRequestModel(otp:encryptOtp,msisdn:GlobalData.shared.msisdn)
                
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.otpVerifyNumber(param: request))
                await MainActor.run {
                    if addPostObject != nil {
                        output?.otpVerifyRequestResponse(response:addPostObject!)
                    }
                }
            } catch let error as AppError {
                await MainActor.run {
                    output?.verifyMobileRequestResponseError(error:error)
                }
                
            }
        }
    }
    
    
}
