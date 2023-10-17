//
//  RegisterMobileNumberPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

class RegisterMobileNumberPresenter {
    
    // MARK: Properties
    
    weak var view : RegisterMobileNumberViewProtocol?
    var router: RegisterMobileNumberRouterProtocol?
    var interactor: RegisterMobileNumberInteractorProtocol?
}

extension RegisterMobileNumberPresenter: RegisterMobileNumberPresenterProtocol {
    
    
    
    func checkMobileNumberStatus(msisdn: String) {
        Loader.shared.showFullScreen()
        interactor?.checkMobileNumberStatusFromServer(msisdn: msisdn)
    }
    
    func navigateToVerify(msisdn: String, ref: RegisterMobileNumberViewController) {
        router?.go(to: .navigateToOtp(msisdn: msisdn, ref: ref))
    }
    
    func navigateToTermsCondition(privacyType: PrivacypolicyType) {
        router?.go(to: .navigateToPrivacy(privacyEnumType: privacyType))
    }
    
    func validateOtpAndSelection(msidn : String,isTermsChecked:Bool,isPrivacyChecked : Bool) -> (msidn : Bool, isTermsChecked : Bool, isPrivacyChecked : Bool) {
        return (msidn.count > 8, isTermsChecked, isPrivacyChecked)
    }
}

extension RegisterMobileNumberPresenter: RegisterMobileNumberInteractorOutputProtocol {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel) {
        Loader.shared.hideFullScreen()
        if let data = response.data {
            GlobalData.shared.msisdnStatusData = data
            GlobalData.shared.isSingleAccount = data.isSingleAccount ?? false
            view?.registerStatusRequestResponse(response: response)
        }
    }
    
    func registerStatusRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
        //view?.registerStatusRequestResponseError(error: error)
    }
    
    
}
