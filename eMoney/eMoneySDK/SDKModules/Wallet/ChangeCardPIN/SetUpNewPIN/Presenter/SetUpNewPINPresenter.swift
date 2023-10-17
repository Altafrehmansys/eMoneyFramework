//
//  SetUpNewPINPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

class SetUpNewPINPresenter {

    // MARK: Properties

    weak var view: SetUpNewPINViewProtocol?
    var router: SetUpNewPINRouterProtocol?
    var interactor: SetUpNewPINInteractorProtocol?
}

extension SetUpNewPINPresenter: SetUpNewPINPresenterProtocol {
    
    func loadData() {
    
    }
}

extension SetUpNewPINPresenter: SetUpNewPINInteractorOutputProtocol {
    
}

extension SetUpNewPINPresenter{
    func navigateToConfirmCardPIN() {
        self.router?.go(to: .navigateToConfirmCardPIN)
    }
}
