//
//  ImtTermsConditionContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 02/06/2023.
//  
//

import Foundation

protocol ImtTermsConditionViewProtocol: ViperView {
    
}

protocol ImtTermsConditionPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol ImtTermsConditionInteractorProtocol: ViperInteractor {
    
}

protocol ImtTermsConditionInteractorOutputProtocol: AnyObject {
}

protocol ImtTermsConditionRouterProtocol: ViperRouter {
    func go(to route: ImtTermsConditionRouter.Route)
}
