//
//  RegisterPinContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation

protocol RegisterPinViewProtocol: ViperView {
    
}

protocol RegisterPinPresenterProtocol: ViperPresenter {
    func navigateToReEnterPin(pin:String,flowEnum : UserJourneyFlow)
}

protocol RegisterPinInteractorProtocol: ViperInteractor {
    
}

protocol RegisterPinInteractorOutputProtocol: AnyObject {
}

protocol RegisterPinRouterProtocol: ViperRouter {
    func go(to route: RegisterPinRouter.Route)
}
