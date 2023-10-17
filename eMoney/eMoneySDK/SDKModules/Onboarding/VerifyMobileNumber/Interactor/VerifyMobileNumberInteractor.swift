//
//  VerifyMobileNumberInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

class VerifyMobileNumberInteractor {
    // MARK: Properties

    weak var output: VerifyMobileNumberInteractorOutputProtocol?

}

extension VerifyMobileNumberInteractor: VerifyMobileNumberInteractorProtocol {
    //Implement your services
    func initiatePinRequestFromServer(resend: Bool, isQuestionSkip: Bool, isUnblockFlow: Bool) {
        Task {
            do {
                let request = InitiatePinRequestModel(resendFlag: resend, isSecretQuestionSkip: isQuestionSkip, isUnblockFlow: isUnblockFlow)
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.initiatePin(param: request))
                print(addPostObject ?? "")
                await MainActor.run {
                    if addPostObject != nil {
                        output?.initiatePinRequestResponse(response:addPostObject!)
                    }
                }
            } catch let error as AppError {
                print(error.localizedDescription)
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
                print(addPostObject ?? "")
                await MainActor.run {
                    if addPostObject != nil {
                        output?.otpSendRequestResponse(response:addPostObject!)
                    }
                   
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.otpSendRequestError(error: error)
                }
                
            }
        }
    }
    
    func verifyOtpRequestResponseFromServer(otp: String) {
        Task {
            do {
                guard let encryptOtp = try? otp.aesEncrypt(key:EncryptionKey.pinKey) else {return}
                
                var statuss = GlobalData.shared.status
                if statuss != "pin_reset" {
                    statuss = ""
                }
                let request = VerifyMobileNumberOtpVerifyRequestModel(otp: encryptOtp,msisdn:GlobalData.shared.msisdn,status: statuss)
                
                let addPostObject:VerifyMobileNumberResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.otpVerifyNumber(param: request))
                print(addPostObject ?? "")
                await MainActor.run {
                    if addPostObject != nil {
                        output?.otpVerifyRequestResponse(response:addPostObject!)
                    }
                }
                
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.verifyMobileRequestResponseError(error:error)
                }
                
            }
        }
    }
    
    
}
