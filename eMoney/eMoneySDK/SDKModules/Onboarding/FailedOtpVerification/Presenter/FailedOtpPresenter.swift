//
//  FailedOtpPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

class FailedOtpPresenter {

    // MARK: Properties

    weak var view: FailedOtpViewProtocol?
    var router: FailedOtpRouterProtocol?
    var interactor: FailedOtpInteractorProtocol?
}

extension FailedOtpPresenter: FailedOtpPresenterProtocol {
    
    func loadData() {
    
    }
}

extension FailedOtpPresenter: FailedOtpInteractorOutputProtocol {
    
}
