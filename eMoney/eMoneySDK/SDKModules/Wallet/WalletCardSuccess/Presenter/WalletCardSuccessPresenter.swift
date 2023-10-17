//
//  WalletCardSuccessPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

class WalletCardSuccessPresenter {

    // MARK: Properties

    weak var view: WalletCardSuccessViewProtocol?
    var router: WalletCardSuccessRouterProtocol?
    var interactor: WalletCardSuccessInteractorProtocol?
}

extension WalletCardSuccessPresenter: WalletCardSuccessPresenterProtocol {
    
    func loadData() {
    
    }
}

extension WalletCardSuccessPresenter: WalletCardSuccessInteractorOutputProtocol {
    
}
