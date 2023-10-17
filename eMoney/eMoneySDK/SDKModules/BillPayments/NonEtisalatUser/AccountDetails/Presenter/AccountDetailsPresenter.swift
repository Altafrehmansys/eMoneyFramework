//
//  AccountDetailsPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 24/05/2023.
//  
//

import Foundation

class AccountDetailsPresenter {

    // MARK: Properties

    weak var view: AccountDetailsViewProtocol?
    var router: AccountDetailsRouterProtocol?
    var interactor: AccountDetailsInteractorProtocol?

}

extension AccountDetailsPresenter: AccountDetailsPresenterProtocol {
    
    func loadData() {
        view?.setupUI()

    }
    func navigateToSelectPlan() {
        router?.go(to: .selectPlan)
    }
    
    
}

extension AccountDetailsPresenter: AccountDetailsInteractorOutputProtocol {
    
}
