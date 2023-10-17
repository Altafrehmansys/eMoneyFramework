//
//  WalletSavedAccountContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 10/07/2023.
//  
//

import Foundation

protocol WalletSavedAccountViewProtocol: ViperView {
    
}

protocol WalletSavedAccountPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol WalletSavedAccountInteractorProtocol: ViperInteractor {
    
}

protocol WalletSavedAccountInteractorOutputProtocol: AnyObject {
}

//protocol WalletSavedAccountRouterProtocol: ViperRouter {
//    func go(to route: WalletSavedAccountRouter.Route)
//}
