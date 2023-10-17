//
//  BillDEWAEasypayNumberInfoPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation

class BillDEWAEasypayNumberInfoPresenter {

    // MARK: Properties

    weak var view: BillDEWAEasypayNumberInfoViewProtocol?
    var router: BillDEWAEasypayNumberInfoRouterProtocol?
    var interactor: BillDEWAEasypayNumberInfoInteractorProtocol?
}

extension BillDEWAEasypayNumberInfoPresenter: BillDEWAEasypayNumberInfoPresenterProtocol {
    
    func loadData() {
    
    }
}

extension BillDEWAEasypayNumberInfoPresenter: BillDEWAEasypayNumberInfoInteractorOutputProtocol {
    
}
