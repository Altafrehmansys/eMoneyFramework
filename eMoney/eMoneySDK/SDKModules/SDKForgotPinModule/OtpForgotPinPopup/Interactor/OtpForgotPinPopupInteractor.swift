//
//  OtpForgotPinPopupInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/06/2023.
//  
//

import Foundation

class OtpForgotPinPopupInteractor {
    // MARK: Properties

    weak var output: OtpForgotPinPopupInteractorOutputProtocol?
}

extension OtpForgotPinPopupInteractor: OtpForgotPinPopupInteractorProtocol {
    //Implement your services
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
    
    func getTokenRequestFromServer() {
        Task {
            do {
                let response:TokenResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.getToken(token: "bW9iaWxlLWZlOnBhc3N3b3JkMTIz"))
                await MainActor.run {
                    SDKColors.shared.accessToken = response?.data?.accessToken
                    output?.getTokenRequestResponse()
                }

            } catch let error as AppError {
                await MainActor.run {
                    print(error)
                    Loader.shared.hideFullScreen()
                    SDKColors.shared.onFailure?("", error.errorDescription)
                    Alert.showError(title: error.title, message: error.errorDescription)
                }
            }
        }
    }
}
