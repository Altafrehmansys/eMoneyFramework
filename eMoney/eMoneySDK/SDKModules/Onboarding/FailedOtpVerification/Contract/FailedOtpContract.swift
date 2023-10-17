//
//  FailedOtpContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation

protocol FailedOtpViewProtocol: ViperView {
    
}

protocol FailedOtpPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol FailedOtpInteractorProtocol: ViperInteractor {
    
}

protocol FailedOtpInteractorOutputProtocol: AnyObject {
}

protocol FailedOtpRouterProtocol: ViperRouter {
    func go(to route: FailedOtpRouter.Route)
}
