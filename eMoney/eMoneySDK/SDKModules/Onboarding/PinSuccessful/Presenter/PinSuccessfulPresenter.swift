//
//  PinSuccessfulPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation

class PinSuccessfulPresenter {

    // MARK: Properties

    weak var view: PinSuccessfulViewProtocol?
    var router: PinSuccessfulRouterProtocol?
    var interactor: PinSuccessfulInteractorProtocol?
}

extension PinSuccessfulPresenter: PinSuccessfulPresenterProtocol {
    
    func loadData() {
    
    }
    func moveToLoginView() {
        router?.go(to: .loginView)
    }
}

extension PinSuccessfulPresenter: PinSuccessfulInteractorOutputProtocol {
    
}
