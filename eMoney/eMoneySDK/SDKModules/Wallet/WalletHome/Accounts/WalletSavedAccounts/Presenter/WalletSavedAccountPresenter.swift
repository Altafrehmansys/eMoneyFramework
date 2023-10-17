//
//  WalletSavedAccountPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 10/07/2023.
//  
//

import Foundation

class WalletSavedAccountPresenter {

    // MARK: Properties

    weak var view: WalletSavedAccountViewProtocol?
//    var router: WalletSavedAccountRouterProtocol?
    var interactor: WalletSavedAccountInteractorProtocol?
}

extension WalletSavedAccountPresenter: WalletSavedAccountPresenterProtocol {
    
    func loadData() {
    
    }
}

extension WalletSavedAccountPresenter: WalletSavedAccountInteractorOutputProtocol {
    
}
