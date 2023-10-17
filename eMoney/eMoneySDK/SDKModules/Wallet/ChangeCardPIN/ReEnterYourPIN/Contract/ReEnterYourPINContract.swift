//
//  ReEnterYourPINContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

protocol ReEnterYourPINViewProtocol: ViperView {
    
}

protocol ReEnterYourPINPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol ReEnterYourPINInteractorProtocol: ViperInteractor {
    
}

protocol ReEnterYourPINInteractorOutputProtocol: AnyObject {
}

protocol ReEnterYourPINRouterProtocol: ViperRouter {
    func go(to route: ReEnterYourPINRouter.Route)
}
