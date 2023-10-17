//
//  TermsConditionsContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

protocol TermsConditionsViewProtocol: ViperView {
    func termsConditionResponse(response: TermsConditionsResponseModel)
    func termsConditionResponseError(error: AppError)
}

protocol TermsConditionsPresenterProtocol: ViperPresenter {
    func getTermsAndConditionsFromServer(type:String)
}

protocol TermsConditionsInteractorProtocol: ViperInteractor {
    func getTermsConditionFromServer(type : String)
}

protocol TermsConditionsInteractorOutputProtocol: AnyObject {
    func termsConditonRequestResponse(response: TermsConditionsResponseModel)
    func termsConditonRequestResponseError(error: AppError)
    
}

protocol TermsConditionsRouterProtocol: ViperRouter {
    func go(to route: TermsConditionsRouter.Route)
}
