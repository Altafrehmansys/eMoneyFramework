//
//  ReEnterPinPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation
import UIKit

class ReEnterPinPresenter {

    // MARK: Properties

    weak var view: ReEnterPinViewProtocol?
    var router: ReEnterPinRouterProtocol?
    var interactor: ReEnterPinInteractorProtocol?
    
    var isBiomatricEnabled:Bool = false
    var pin:String = ""
}

extension ReEnterPinPresenter: ReEnterPinPresenterProtocol {
    func navigateToNotificationScreen() {
        router?.go(to: .navigateToNotificationScreen)
    }
    
    func callResetApi(resetPinObj : ResetPinRequestModel) {
        Loader.shared.showFullScreen()
        interactor?.callResetApi(request: resetPinObj)
    }
    func navigateSuccess(){
        router?.go(to: .navigateForgotPinSuccess)
    }
    func navigateForgotPinSuccess() {
        router?.go(to: .navigateForgotPinSuccess)
    }
    func navigateBackToLogin() {
        router?.go(to: .backToLogin)
    }
    func callRegistrationApi(pin: String, isBiomatricEnabled:Bool) {
        self.isBiomatricEnabled = isBiomatricEnabled
        
        self.pin = pin
        let request = RegistrationRequestModel()
        request.email = GlobalData.shared.userEmail
        let val = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
        request.pin = val ?? ""
        request.profileName = UserProfile.physicalKYC.rawValue
        request.isSingleAccount = GlobalData.shared.isSingleAccount
        request.dateOfBirth = GlobalData.shared.userEidInfo?.dob ?? ""
        request.nationality = GlobalData.shared.userEidInfo?.nationalityIso3 ?? ""
        request.idNumber = GlobalData.shared.userEidInfo?.emiratesId ?? ""
        request.idExpiryDate = GlobalData.shared.userEidInfo?.expiry ?? ""
        request.firstName = GlobalData.shared.userEidInfo?.firstName ?? ""
        request.middleName = GlobalData.shared.userEidInfo?.middleName ?? ""
        request.lastName = GlobalData.shared.userEidInfo?.lastName ?? ""
        request.fullName = GlobalData.shared.userEidInfo?.fullName ?? ""
        request.gender = GlobalData.shared.userEidInfo?.sex ?? ""
        request.cacheFlow = true
        
//        if let type = GlobalData.shared.registrationType {
//            switch type {
//            case .noKyc:
//                request.profileName = UserProfile.noKYC.rawValue
//            case .physicalKyc:
//                if let eidInfo = GlobalData.shared.userEidInfo {
//                    request.dateOfBirth = eidInfo.dob
//                    request.nationality = eidInfo.nationalityIso3
//                    request.idNumber = eidInfo.emiratesId
//                    request.idExpiryDate = eidInfo.expiry
//                    request.firstName = eidInfo.firstName
//                    request.middleName = eidInfo.middleName
//                    request.lastName = eidInfo.lastName
//                    request.fullName = eidInfo.fullName
//                    request.gender = eidInfo.sex
//                }
//                request.profileName = UserProfile.physicalKYC.rawValue
//            }
//        }
        
        Loader.shared.showFullScreen()
        interactor?.registerUser(request: request)

    }
}

extension ReEnterPinPresenter: ReEnterPinInteractorOutputProtocol {
    func resetPinResponse(response: ResetPinResponseModel) {
        Loader.shared.hideFullScreen()
        view?.resetPinRequestResponse(response: response)
    }
    
    func onResetError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.onResetRequestError(error: error)
    }
    
    func onRegisterUserResponse(response: RegistrationResponseModel?) {
        Loader.shared.hideFullScreen()
        if let response = response {
            if isBiomatricEnabled{
                UserDefaultHelper.userBiomatricToken = self.pin
            }
            UserDefaultHelper.userLoginPin = self.pin
            GlobalData.shared.registerAsAMLFailed = response.responseCode == "50002" ? true:false
//            Loader.shared.showFullScreen()
//            interactor?.loginUser(pin: self.pin)
            UserDefaultHelper.msisdn = GlobalData.shared.msisdn
            router?.go(to: .navigateToSuccess)
        }
    }
    
    func onRegisterUserError(error: AppError) {
        Loader.shared.hideFullScreen()
        if error.errorCode == "50002" {
            if isBiomatricEnabled{
                UserDefaultHelper.userBiomatricToken = self.pin
            }
            UserDefaultHelper.userLoginPin = self.pin
            GlobalData.shared.registerAsAMLFailed = true
//            Loader.shared.showFullScreen()
//            interactor?.loginUser(pin: self.pin)
            UserDefaultHelper.msisdn = GlobalData.shared.msisdn
            router?.go(to: .navigateToSuccess)
        }else{
            Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
        }
    }
    
    func loginRequestResponse(response: LoginResponseModel) {
        Loader.shared.hideFullScreen()
        
        if let data = response.data {
            GlobalData.shared.loginData = data
            UserDefaultHelper.userSessionToken = data.userToken
            if let userName = data.fullName {
                UserDefaultHelper.userName = userName
            }
            
            if data.result == UserLoginStatus.success.rawValue || data.result == UserLoginStatus.limited.rawValue {
                //TODO: - call wallet id api
                UserDefaultHelper.msisdn = GlobalData.shared.msisdn
                router?.go(to: .navigateToSuccess)
            }else{
                Alert.showBottomSheetError(title: "error".localized, message: data.result ?? "Something went wrong!")
            }
            
        }
    }
    func loginRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.errorDescription, message: "")
    }
    
}
