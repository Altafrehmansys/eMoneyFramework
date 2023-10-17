//
//  AddReceiptContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 07/06/2023.
//  
//

import Foundation

protocol AddReceiptViewProtocol: ViperView {
    
}

protocol AddReceiptPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol AddReceiptInteractorProtocol: ViperInteractor {
    
}

protocol AddReceiptInteractorOutputProtocol: AnyObject {
}

protocol AddReceiptRouterProtocol: ViperRouter {
    func go(to route: AddReceiptRouter.Route)
}
