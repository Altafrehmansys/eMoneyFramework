//
//  EnterYourPINPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

class EnterYourPINPresenter {

    // MARK: Properties

    weak var view: EnterYourPINViewProtocol?
    var router: EnterYourPINRouterProtocol?
    var interactor: EnterYourPINInteractorProtocol?
}

extension EnterYourPINPresenter: EnterYourPINPresenterProtocol {
    
    func loadData() {
    
    }
}

extension EnterYourPINPresenter: EnterYourPINInteractorOutputProtocol {
    
}

extension EnterYourPINPresenter{
    func navigateToForgotPINScreen() {
        self.router?.go(to: .navigateToForgotPINScreen)
    }
}
