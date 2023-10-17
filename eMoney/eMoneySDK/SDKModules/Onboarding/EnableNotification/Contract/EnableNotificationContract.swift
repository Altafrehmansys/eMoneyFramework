//
//  EnableNotificationContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation

protocol EnableNotificationViewProtocol: ViperView {
    
}

protocol EnableNotificationPresenterProtocol: ViperPresenter {
    func routeToSelectCard()
}

protocol EnableNotificationInteractorProtocol: ViperInteractor {
    
}

protocol EnableNotificationInteractorOutputProtocol: AnyObject {
}

protocol EnableNotificationRouterProtocol: ViperRouter {
    func go(to route: EnableNotificationRouter.Route)
}
