//
//  ScanQRCodeToPayContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/05/2023.
//  
//

import Foundation

protocol ScanQRCodeToPayViewProtocol: ViperView {
    func setupUI()
}

protocol ScanQRCodeToPayPresenterProtocol: ViperPresenter {
    func loadData()
    func navigateToSendMoneyEnterAmount()
}

protocol ScanQRCodeToPayInteractorProtocol: ViperInteractor {
    
}

protocol ScanQRCodeToPayInteractorOutputProtocol: AnyObject {
}

protocol ScanQRCodeToPayRouterProtocol: ViperRouter {
    func go(to route: ScanQRCodeToPayRouter.Route)
}
