//
//  EnterYourPINContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

protocol EnterYourPINViewProtocol: ViperView {
    
}

protocol EnterYourPINPresenterProtocol: ViperPresenter {
    func loadData()
    
    func navigateToForgotPINScreen()
}

protocol EnterYourPINInteractorProtocol: ViperInteractor {
    
}

protocol EnterYourPINInteractorOutputProtocol: AnyObject {
}

protocol EnterYourPINRouterProtocol: ViperRouter {
    func go(to route: EnterYourPINRouter.Route)
}
