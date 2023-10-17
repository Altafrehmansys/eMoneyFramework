//
//  LeanCoolOffBottomSheetContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 31/07/2023.
//  
//

import Foundation

protocol LeanCoolOffBottomSheetViewProtocol: ViperView {
    func setupUI()
    func showCoolDownTimeForSeconds(seconds: Int)
}

protocol LeanCoolOffBottomSheetPresenterProtocol: ViperPresenter {
    func loadData()
    func dismiss()
}

protocol LeanCoolOffBottomSheetInteractorProtocol: ViperInteractor {
    
}

protocol LeanCoolOffBottomSheetInteractorOutputProtocol: AnyObject {
}

protocol LeanCoolOffBottomSheetRouterProtocol: ViperRouter {
    func go(to route: LeanCoolOffBottomSheetRouter.Route)
}
