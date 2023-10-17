//
//  BillDEWAAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation

class BillDEWAAccountDetailsPresenter {

    // MARK: Properties

    weak var view: BillDEWAAccountDetailsViewProtocol?
    var router: BillDEWAAccountDetailsRouterProtocol?
    var interactor: BillDEWAAccountDetailsInteractorProtocol?
}

extension BillDEWAAccountDetailsPresenter: BillDEWAAccountDetailsPresenterProtocol {
    
    func loadData() {
    
    }
    
    func infoBtnTapped() {
        router?.go(to: .easyPayInfo)
    }
    func didContinueButtonTapped() {
        router?.go(to: .pay)
    }
}

extension BillDEWAAccountDetailsPresenter: BillDEWAAccountDetailsInteractorOutputProtocol {
    
}
