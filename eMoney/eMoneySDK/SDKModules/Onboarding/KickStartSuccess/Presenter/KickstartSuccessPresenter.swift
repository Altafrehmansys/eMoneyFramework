//
//  KickstartSuccessPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 01/05/2023.
//  
//

import Foundation

class KickstartSuccessPresenter {

    // MARK: Properties

    weak var view: KickstartSuccessViewProtocol?
    var router: KickstartSuccessRouterProtocol?
    var interactor: KickstartSuccessInteractorProtocol?
}

extension KickstartSuccessPresenter: KickstartSuccessPresenterProtocol {
    
    func loadData() {
    
    }
    func navigateToHome() {
        router?.go(to: .home)
    }
}

extension KickstartSuccessPresenter: KickstartSuccessInteractorOutputProtocol {
    
}
