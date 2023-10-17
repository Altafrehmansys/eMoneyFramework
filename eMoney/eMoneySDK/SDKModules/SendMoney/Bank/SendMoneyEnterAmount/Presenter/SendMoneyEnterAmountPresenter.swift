//
//  SendMoneyEnterAmountPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation

class SendMoneyEnterAmountPresenter {

    // MARK: Properties

    weak var view: SendMoneyEnterAmountViewProtocol?
    var router: SendMoneyEnterAmountRouterProtocol?
    var interactor: SendMoneyEnterAmountInteractorProtocol?
}

extension SendMoneyEnterAmountPresenter: SendMoneyEnterAmountPresenterProtocol {
    
    func loadData() {
    
    }
    func navigateToSendMoneyPaymentDetails() {
        self.router?.go(to: .navigateSendMoneyPaymentDetails)
    }
}

extension SendMoneyEnterAmountPresenter: SendMoneyEnterAmountInteractorOutputProtocol {
    
}

