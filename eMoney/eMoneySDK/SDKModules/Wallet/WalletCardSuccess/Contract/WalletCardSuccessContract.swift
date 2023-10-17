//
//  WalletCardSuccessContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

protocol WalletCardSuccessViewProtocol: ViperView {
    
}

protocol WalletCardSuccessPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol WalletCardSuccessInteractorProtocol: ViperInteractor {
    
}

protocol WalletCardSuccessInteractorOutputProtocol: AnyObject {
}

protocol WalletCardSuccessRouterProtocol: ViperRouter {
    func go(to route: WalletCardSuccessRouter.Route)
}
