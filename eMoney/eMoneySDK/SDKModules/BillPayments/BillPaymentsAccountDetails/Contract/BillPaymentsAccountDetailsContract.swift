//
//  BillPaymentsAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//  
//

import Foundation

protocol BillPaymentsAccountDetailsViewProtocol: ViperView {
    
}

protocol BillPaymentsAccountDetailsPresenterProtocol: ViperPresenter {
    func didTapContinueBtn()
    func loadData()
}

protocol BillPaymentsAccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol BillPaymentsAccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol BillPaymentsAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: BillPaymentsAccountDetailsRouter.Route)
}
