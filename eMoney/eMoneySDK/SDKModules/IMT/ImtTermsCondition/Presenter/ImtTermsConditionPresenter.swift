//
//  ImtTermsConditionPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 02/06/2023.
//  
//

import Foundation

class ImtTermsConditionPresenter {

    // MARK: Properties

    weak var view: ImtTermsConditionViewProtocol?
    var router: ImtTermsConditionRouterProtocol?
    var interactor: ImtTermsConditionInteractorProtocol?
}

extension ImtTermsConditionPresenter: ImtTermsConditionPresenterProtocol {
    
    func loadData() {
    
    }
}

extension ImtTermsConditionPresenter: ImtTermsConditionInteractorOutputProtocol {
    
}
