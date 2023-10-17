//
//  AddAppleWalletPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 27/04/2023.
//  
//

import Foundation

class AddAppleWalletPresenter {

    // MARK: Properties

    weak var view: AddAppleWalletViewProtocol?
    var router: AddAppleWalletRouterProtocol?
    var interactor: AddAppleWalletInteractorProtocol?
}

extension AddAppleWalletPresenter: AddAppleWalletPresenterProtocol {
    
    func loadData() {
    
    }
    func navigateToWelcomeScreen() {
        router?.go(to: .navigateToWelcome)
    }
}

extension AddAppleWalletPresenter: AddAppleWalletInteractorOutputProtocol {
    
}
