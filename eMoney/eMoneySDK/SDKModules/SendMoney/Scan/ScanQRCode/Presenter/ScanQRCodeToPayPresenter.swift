//
//  ScanQRCodeToPayPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/05/2023.
//  
//

import Foundation

class ScanQRCodeToPayPresenter {

    // MARK: Properties

    weak var view: ScanQRCodeToPayViewProtocol?
    var router: ScanQRCodeToPayRouterProtocol?
    var interactor: ScanQRCodeToPayInteractorProtocol?
}

extension ScanQRCodeToPayPresenter: ScanQRCodeToPayPresenterProtocol {
    
    func loadData() {
        self.view?.setupUI()
    }
    func navigateToSendMoneyEnterAmount() {
        self.router?.go(to: .moveToEnterPaymentAmountScreen)
    }
}

extension ScanQRCodeToPayPresenter: ScanQRCodeToPayInteractorOutputProtocol {
    
}
