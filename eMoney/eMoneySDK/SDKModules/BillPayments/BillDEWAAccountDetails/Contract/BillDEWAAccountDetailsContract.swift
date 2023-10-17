//
//  BillDEWAAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 01/06/2023.
//  
//

import Foundation

protocol BillDEWAAccountDetailsViewProtocol: ViperView {
    
}

protocol BillDEWAAccountDetailsPresenterProtocol: ViperPresenter {
    func loadData()
    func infoBtnTapped()
    func didContinueButtonTapped()
}

protocol BillDEWAAccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol BillDEWAAccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol BillDEWAAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: BillDEWAAccountDetailsRouter.Route)
}
