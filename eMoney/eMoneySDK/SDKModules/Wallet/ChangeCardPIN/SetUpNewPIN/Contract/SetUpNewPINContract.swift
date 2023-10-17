//
//  SetUpNewPINContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

protocol SetUpNewPINViewProtocol: ViperView {
    
}

protocol SetUpNewPINPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToConfirmCardPIN()
}

protocol SetUpNewPINInteractorProtocol: ViperInteractor {
    
}

protocol SetUpNewPINInteractorOutputProtocol: AnyObject {
}

protocol SetUpNewPINRouterProtocol: ViperRouter {
    func go(to route: SetUpNewPINRouter.Route)
}
