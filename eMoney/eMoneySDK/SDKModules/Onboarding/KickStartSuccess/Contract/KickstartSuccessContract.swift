//
//  KickstartSuccessContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/05/2023.
//  
//

import Foundation

protocol KickstartSuccessViewProtocol: ViperView {
    
}

protocol KickstartSuccessPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToHome()
}

protocol KickstartSuccessInteractorProtocol: ViperInteractor {
    
}

protocol KickstartSuccessInteractorOutputProtocol: AnyObject {
}

protocol KickstartSuccessRouterProtocol: ViperRouter {
    func go(to route: KickstartSuccessRouter.Route)
}
