//
//  PinSuccessfulPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation

class EmiratesIdSuccessPresenter {

    // MARK: Properties

    weak var view: EmiratesIdSuccessViewProtocol?
    var router: EmiratesIdSuccessRouterProtocol?
    var interactor: EmiratesIdSuccessInteractorProtocol?
}

extension EmiratesIdSuccessPresenter: EmiratesIdSuccessPresenterProtocol {
    
    func loadData() {
    
    }
    func moveToLoginView() {
        router?.go(to: .loginView)
    }
}

extension EmiratesIdSuccessPresenter: EmiratesIdSuccessInteractorOutputProtocol {
    
}
