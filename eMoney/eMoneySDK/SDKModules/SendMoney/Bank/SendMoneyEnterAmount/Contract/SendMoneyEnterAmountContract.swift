//
//  SendMoneyEnterAmountContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//  
//

import Foundation

protocol SendMoneyEnterAmountViewProtocol: ViperView {
    
}

protocol SendMoneyEnterAmountPresenterProtocol: ViperPresenter {
    func loadData()
    
    func navigateToSendMoneyPaymentDetails()

}

protocol SendMoneyEnterAmountInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneyEnterAmountInteractorOutputProtocol: AnyObject {
}

protocol SendMoneyEnterAmountRouterProtocol: ViperRouter {
    func go(to route: SendMoneyEnterAmountRouter.Route)
}
