//
//  BillDEWAWalletBalanceContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

protocol BillDEWAWalletBalanceViewProtocol: ViperView {
    
}

protocol BillDEWAWalletBalancePresenterProtocol: ViperPresenter {
    func loadData()
}

protocol BillDEWAWalletBalanceInteractorProtocol: ViperInteractor {
    
}

protocol BillDEWAWalletBalanceInteractorOutputProtocol: AnyObject {
}

protocol BillDEWAWalletBalanceRouterProtocol: ViperRouter {
    func go(to route: BillDEWAWalletBalanceRouter.Route)
}
