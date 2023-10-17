//
//  TermsConditionsPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class TermsConditionsPresenter {

    // MARK: Properties

    weak var view: TermsConditionsViewProtocol?
    var router: TermsConditionsRouterProtocol?
    var interactor: TermsConditionsInteractorProtocol?
}

extension TermsConditionsPresenter: TermsConditionsPresenterProtocol {
    func getTermsAndConditionsFromServer(type: String) {
        Loader.shared.showFullScreen()
        interactor?.getTermsConditionFromServer(type: type)
    }
    
}

extension TermsConditionsPresenter: TermsConditionsInteractorOutputProtocol {
    func termsConditonRequestResponse(response: TermsConditionsResponseModel) {
        Loader.shared.hideFullScreen()
        view?.termsConditionResponse(response: response)
    }
    
    func termsConditonRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.termsConditionResponseError(error: error)
    }
    
    
}
