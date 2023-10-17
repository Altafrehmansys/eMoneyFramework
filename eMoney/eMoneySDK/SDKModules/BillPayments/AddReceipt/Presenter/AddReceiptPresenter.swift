//
//  AddReceiptPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 07/06/2023.
//  
//

import Foundation

class AddReceiptPresenter {

    // MARK: Properties

    weak var view: AddReceiptViewProtocol?
    var router: AddReceiptRouterProtocol?
    var interactor: AddReceiptInteractorProtocol?
}

extension AddReceiptPresenter: AddReceiptPresenterProtocol {
    
    func loadData() {
    
    }
}

extension AddReceiptPresenter: AddReceiptInteractorOutputProtocol {
    
}
