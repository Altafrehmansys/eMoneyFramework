//
//  AddAppleWalletContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 27/04/2023.
//  
//

import Foundation

protocol AddAppleWalletViewProtocol: ViperView {
    
}

protocol AddAppleWalletPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToWelcomeScreen()
}

protocol AddAppleWalletInteractorProtocol: ViperInteractor {
    
}

protocol AddAppleWalletInteractorOutputProtocol: AnyObject {
}

protocol AddAppleWalletRouterProtocol: ViperRouter {
    func go(to route: AddAppleWalletRouter.Route)
}
