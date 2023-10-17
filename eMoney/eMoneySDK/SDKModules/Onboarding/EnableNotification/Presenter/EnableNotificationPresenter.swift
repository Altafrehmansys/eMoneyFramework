//
//  EnableNotificationPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/04/2023.
//  
//

import Foundation

class EnableNotificationPresenter {

    // MARK: Properties

    weak var view: EnableNotificationViewProtocol?
    var router: EnableNotificationRouterProtocol?
    var interactor: EnableNotificationInteractorProtocol?
}

extension EnableNotificationPresenter: EnableNotificationPresenterProtocol {
    
    func routeToSelectCard() {
        if GlobalData.shared.registrationType == .noKyc {
            router?.go(to: .routeToKickStart)
        }else{
            router?.go(to: .routeToCardSelect)
        }
    }
}

extension EnableNotificationPresenter: EnableNotificationInteractorOutputProtocol {
    
}
