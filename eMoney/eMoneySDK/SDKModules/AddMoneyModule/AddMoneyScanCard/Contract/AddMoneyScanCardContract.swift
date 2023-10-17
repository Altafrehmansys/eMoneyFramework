//
//  AddMoneyScanCardContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 07/05/2023.
//  
//

import Foundation

protocol AddMoneyScanCardViewProtocol: ViperView {
    var presenter: AddMoneyScanCardPresenterProtocol! { get set }
    
    func setupUI()
    func startCaptureSession()
}

protocol AddMoneyScanCardPresenterProtocol: ViperPresenter {
    func loadData()
    
    func sendBack(cardDetails: CardDetails)
}

protocol AddMoneyScanCardInteractorProtocol: ViperInteractor {
    
}

protocol AddMoneyScanCardInteractorOutputProtocol: AnyObject {
}

protocol AddMoneyScanCardRouterProtocol: ViperRouter {
    func go(to route: AddMoneyScanCardRouter.Route)
}

protocol AddMoneyScanCardRouterOutputProtocol: ViperRouter {
    func didReturnCardData(_ details: CardDetails)
}
