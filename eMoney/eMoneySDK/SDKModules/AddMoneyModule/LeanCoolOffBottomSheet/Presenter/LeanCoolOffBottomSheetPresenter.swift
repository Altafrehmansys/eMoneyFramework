//
//  LeanCoolOffBottomSheetPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 31/07/2023.
//  
//

import Foundation

class LeanCoolOffBottomSheetPresenter {

    // MARK: Properties

    weak var view: LeanCoolOffBottomSheetViewProtocol?
    var router: LeanCoolOffBottomSheetRouterProtocol?
    var interactor: LeanCoolOffBottomSheetInteractorProtocol?
    
    var coolDownTime: Int? = nil
}

extension LeanCoolOffBottomSheetPresenter: LeanCoolOffBottomSheetPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        
        if let coolDown = self.coolDownTime {
            view?.showCoolDownTimeForSeconds(seconds: coolDown)
        }
    }
    
    func dismiss() {
        self.router?.go(to: .dismiss)
    }
}

extension LeanCoolOffBottomSheetPresenter: LeanCoolOffBottomSheetInteractorOutputProtocol {
    
}
