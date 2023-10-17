//
//  BillCompleteRechargeContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 31/05/2023.
//  
//

import Foundation

protocol BillCompleteRechargeViewProtocol: ViperView {
    
}

protocol BillCompleteRechargePresenterProtocol: ViperPresenter {
    var inputs: BillAccountDetailsParameters? { get set }
    func loadData()
}

protocol BillCompleteRechargeInteractorProtocol: ViperInteractor {
    
}

protocol BillCompleteRechargeInteractorOutputProtocol: AnyObject {
}

protocol BillCompleteRechargeRouterProtocol: ViperRouter {
    func go(to route: BillCompleteRechargeRouter.Route)
}
