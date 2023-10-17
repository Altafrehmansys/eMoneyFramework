//
//  LoginPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class LoginPresenter {
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var router: LoginRouterProtocol?
    var interactor: LoginInteractorProtocol?
}

extension LoginPresenter: LoginPresenterProtocol {
    func loginApiCall(pin: String) {
        Loader.shared.showFullScreen()
        interactor?.sendLoginPinToServer(pin: pin)
    }
    
    func naviateToForgotPassword() {
        router?.go(to: .navigateToForgotPin)
    }
    
    func proceedWithLogin(data:LoginData){
        if data.upgradeScreen == "pin_reset" && data.oldDeviceId != nil {
            
            let statusData = RegisterMobileNumberData()
            statusData.status = "pin_reset"
            statusData.oldDeviceId = data.oldDeviceId
            GlobalData.shared.msisdnStatusData = statusData
            router?.go(to: .otp)
            
        }else if data.result == UserLoginStatus.success.rawValue || data.result == UserLoginStatus.limited.rawValue {
            //TODO: - call wallet id api
            router?.go(to: .home)
        }else{
            Alert.showBottomSheetError(title: "Error", message: data.result ?? "Something went wrong!")
        }
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginRequestResponse(response: LoginResponseModel) {
        Loader.shared.hideFullScreen()
        
        if let data = response.data {
            GlobalData.shared.loginData = data
            UserDefaultHelper.userSessionToken = data.userToken
            if let userName = data.fullName {
                UserDefaultHelper.userName = userName
            }
            proceedWithLogin(data: data)
        }
    }
    func loginRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.loginResponseError(error: error)
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
}
