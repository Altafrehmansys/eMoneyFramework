//
//  BillDEWAEasypayNumberInfoContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation

protocol BillDEWAEasypayNumberInfoViewProtocol: ViperView {
    
}

protocol BillDEWAEasypayNumberInfoPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol BillDEWAEasypayNumberInfoInteractorProtocol: ViperInteractor {
    
}

protocol BillDEWAEasypayNumberInfoInteractorOutputProtocol: AnyObject {
}

protocol BillDEWAEasypayNumberInfoRouterProtocol: ViperRouter {
    func go(to route: BillDEWAEasypayNumberInfoRouter.Route)
}
