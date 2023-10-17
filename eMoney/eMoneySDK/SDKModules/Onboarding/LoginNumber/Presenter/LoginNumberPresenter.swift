//
//  LoginNumberPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/05/2023.
//  
//

import Foundation

class LoginNumberPresenter {

    // MARK: Properties

    weak var view: LoginNumberViewProtocol?
    var router: LoginNumberRouterProtocol?
    var interactor: LoginNumberInteractorProtocol?
    var msisdn = ""
}

extension LoginNumberPresenter: LoginNumberPresenterProtocol {
    
    func checkMobileNumberStatus(msisdn: String) {
        self.msisdn = msisdn
        Loader.shared.showFullScreen()
        interactor?.checkMobileNumberStatusFromServer(msisdn: msisdn)
    }
    
    func navigateToVerify(msisdn: String) {
        router?.go(to: .navigateToOtp(msisdn: msisdn))
    }
}

extension LoginNumberPresenter: LoginNumberInteractorOutputProtocol {
    
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        if let data = response.data {
            if data.status == MsisdnStatus.registered.rawValue {
                GlobalData.shared.msisdnStatusData = data
                router?.go(to: .navigateToOtp(msisdn: self.msisdn))
            }else{
                view?.registerStatusRequestResponse(response: response)
            }
        }
    }
    func registerStatusRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.registerStatusRequestResponseError(error: error)
    }
    
}
