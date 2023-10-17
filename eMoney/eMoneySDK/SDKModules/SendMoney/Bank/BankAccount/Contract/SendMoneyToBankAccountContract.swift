//
//  SendMoneyToBankAccountContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

protocol SendMoneyToBankAccountViewProtocol: ViperView {
    
}

protocol SendMoneyToBankAccountPresenterProtocol: ViperPresenter {
    func loadData()
    
    // Navigations
    func showIbanInfoView()
    func navigateToSendMoneyEnterAmount()
}

protocol SendMoneyToBankAccountInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneyToBankAccountInteractorOutputProtocol: AnyObject {
}

protocol SendMoneyToBankAccountRouterProtocol: ViperRouter {
    func go(to route: SendMoneyToBankAccountRouter.Route)
    
}
