//
//  ReEnterYourPINPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

class ReEnterYourPINPresenter {

    // MARK: Properties

    weak var view: ReEnterYourPINViewProtocol?
    var router: ReEnterYourPINRouterProtocol?
    var interactor: ReEnterYourPINInteractorProtocol?
}

extension ReEnterYourPINPresenter: ReEnterYourPINPresenterProtocol {
    
    func loadData() {
    
    }
}

extension ReEnterYourPINPresenter: ReEnterYourPINInteractorOutputProtocol {
    
}
