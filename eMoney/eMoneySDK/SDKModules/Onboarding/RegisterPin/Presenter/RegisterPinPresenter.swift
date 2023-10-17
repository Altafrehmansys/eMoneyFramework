//
//  RegisterPinPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 19/04/2023.
//  
//

import Foundation

enum PinSecurity {
    case weakPin
    case strongPin
    case average
}


class RegisterPinPresenter {

    // MARK: Properties

    weak var view: RegisterPinViewProtocol?
    var router: RegisterPinRouterProtocol?
    var interactor: RegisterPinInteractorProtocol?
}

extension RegisterPinPresenter: RegisterPinPresenterProtocol {
    
    func navigateToReEnterPin(pin: String, flowEnum: UserJourneyFlow) {
        router?.go(to: .navigateToReEnterPin(pin: pin, flowType: flowEnum))
    }
}

extension RegisterPinPresenter: RegisterPinInteractorOutputProtocol {
    
}
