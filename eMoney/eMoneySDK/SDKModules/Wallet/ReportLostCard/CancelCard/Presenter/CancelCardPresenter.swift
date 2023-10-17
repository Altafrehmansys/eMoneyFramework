//
//  CancelCardPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation

class CancelCardPresenter {

    // MARK: Properties

    weak var view: CancelCardViewProtocol?
    var router: CancelCardRouterProtocol?
    var interactor: CancelCardInteractorProtocol?
}

extension CancelCardPresenter: CancelCardPresenterProtocol {
    
    func loadData() {
    
    }
}

extension CancelCardPresenter: CancelCardInteractorOutputProtocol {
    
}
