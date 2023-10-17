//
//  AccountDetailsContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 24/05/2023.
//  
//

import Foundation

protocol AccountDetailsViewProtocol: ViperView {
    func setupUI()
}

protocol AccountDetailsPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToSelectPlan()
}

protocol AccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol AccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol AccountDetailsRouterProtocol: ViperRouter {
    func go(to route: AccountDetailsRouter.Route)
}
