//
//  OtpMoneyContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol OtpMoneyViewProtocol: ViperView {
    
}

protocol OtpMoneyPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol OtpMoneyInteractorProtocol: ViperInteractor {
    
}

protocol OtpMoneyInteractorOutputProtocol: AnyObject {
}

protocol OtpMoneyRouterProtocol: ViperRouter {
    func go(to route: OtpMoneyRouter.Route)
}
