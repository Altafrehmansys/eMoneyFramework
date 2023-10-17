//
//  OtpMoneyPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

class OtpMoneyPresenter {

    // MARK: Properties

    weak var view: OtpMoneyViewProtocol?
    var router: OtpMoneyRouterProtocol?
    var interactor: OtpMoneyInteractorProtocol?
}

extension OtpMoneyPresenter: OtpMoneyPresenterProtocol {
    
    func loadData() {
    
    }
}

extension OtpMoneyPresenter: OtpMoneyInteractorOutputProtocol {
    
}
