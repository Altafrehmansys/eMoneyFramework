//
//  BillPaymentsAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 26/05/2023.
//  
//

import Foundation

class BillPaymentsAccountDetailsPresenter {

    // MARK: Properties

    weak var view: BillPaymentsAccountDetailsViewProtocol?
    var router: BillPaymentsAccountDetailsRouterProtocol?
    var interactor: BillPaymentsAccountDetailsInteractorProtocol?
}

extension BillPaymentsAccountDetailsPresenter: BillPaymentsAccountDetailsPresenterProtocol {
    
    func didTapContinueBtn() {
        router?.go(to: .selectPlan)
    }
    func loadData() {
    
    }
}

extension BillPaymentsAccountDetailsPresenter: BillPaymentsAccountDetailsInteractorOutputProtocol {
    
}
