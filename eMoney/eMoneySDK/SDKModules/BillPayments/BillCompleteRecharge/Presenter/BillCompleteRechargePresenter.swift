//
//  BillCompleteRechargePresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 31/05/2023.
//  
//

import Foundation

class BillCompleteRechargePresenter {

    // MARK: Properties

    weak var view: BillCompleteRechargeViewProtocol?
    var router: BillCompleteRechargeRouterProtocol?
    var interactor: BillCompleteRechargeInteractorProtocol?
    var inputs: BillAccountDetailsParameters?
}

extension BillCompleteRechargePresenter: BillCompleteRechargePresenterProtocol {
    
    func loadData() {
    
    }
}

extension BillCompleteRechargePresenter: BillCompleteRechargeInteractorOutputProtocol {
    
}
