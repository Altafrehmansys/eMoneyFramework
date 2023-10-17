//
//  RegisterMobileNumberContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/04/2023.
//  
//

import Foundation

protocol RegisterMobileNumberViewProtocol: ViperView {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel)
    func registerStatusRequestResponseError(error: AppError)
}

protocol RegisterMobileNumberPresenterProtocol: ViperPresenter {
    func checkMobileNumberStatus(msisdn : String)
    func navigateToVerify(msisdn : String, ref: RegisterMobileNumberViewController)
    func validateOtpAndSelection(msidn : String,isTermsChecked:Bool,isPrivacyChecked : Bool) -> (msidn : Bool, isTermsChecked : Bool, isPrivacyChecked : Bool)
    func navigateToTermsCondition(privacyType : PrivacypolicyType)
    
}

protocol RegisterMobileNumberInteractorProtocol: ViperInteractor {
    func checkMobileNumberStatusFromServer(msisdn:String)
}

protocol RegisterMobileNumberInteractorOutputProtocol: AnyObject {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel)
    func registerStatusRequestResponseError(error: AppError)
}

protocol RegisterMobileNumberRouterProtocol: ViperRouter {
    func go(to route: RegisterMobileNumberRouter.Route)
}
