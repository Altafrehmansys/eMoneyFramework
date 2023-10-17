//
//  ThankyouPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/05/2023.
//  
//

import Foundation

class ThankyouPresenter {

    // MARK: Properties

    weak var view: ThankyouViewProtocol?
    var router: ThankyouRouterProtocol?
    var interactor: ThankyouInteractorProtocol?
}

extension ThankyouPresenter: ThankyouPresenterProtocol {
    
    func loadData() {
    
    }
    func navigateToEnterEmail() {
        router?.go(to: .navigateToEnterEmail)
    }
    func navigateToHome() {
        router?.go(to: .home)
    }
}

extension ThankyouPresenter: ThankyouInteractorOutputProtocol {
    
}
