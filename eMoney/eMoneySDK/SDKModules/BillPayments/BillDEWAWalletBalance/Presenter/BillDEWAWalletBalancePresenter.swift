//
//  BillDEWAWalletBalancePresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

class BillDEWAWalletBalancePresenter {

    // MARK: Properties

    weak var view: BillDEWAWalletBalanceViewProtocol?
    var router: BillDEWAWalletBalanceRouterProtocol?
    var interactor: BillDEWAWalletBalanceInteractorProtocol?
}

extension BillDEWAWalletBalancePresenter: BillDEWAWalletBalancePresenterProtocol {
    
    func loadData() {
    
    }
}

extension BillDEWAWalletBalancePresenter: BillDEWAWalletBalanceInteractorOutputProtocol {
    
}
