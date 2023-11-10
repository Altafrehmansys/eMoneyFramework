//
//  EmiratesIdSuccessContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 17/07/2023.
//  
//

import Foundation

protocol EmiratesIdSuccessViewProtocol: ViperView {
    
}

protocol EmiratesIdSuccessPresenterProtocol: ViperPresenter {
    func loadData()
    func moveToLoginView()
}

protocol EmiratesIdSuccessInteractorProtocol: ViperInteractor {
    
}

protocol EmiratesIdSuccessInteractorOutputProtocol: AnyObject {
}

protocol EmiratesIdSuccessRouterProtocol: ViperRouter {
    func go(to route: EmiratesIdSuccessRouter.Route)
}
