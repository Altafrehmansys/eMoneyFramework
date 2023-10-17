//
//  ParkingSMSCopyPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

class ParkingSMSCopyPresenter {

    // MARK: Properties

    weak var view: ParkingSMSCopyViewProtocol?
    var router: ParkingSMSCopyRouterProtocol?
    var interactor: ParkingSMSCopyInteractorProtocol?
    var model:ParkingSMSCopyResponseModel? = nil
    
    private func sendSMS() {
        CommonMethods.openMessagesApp(withReceiver: self.model?.data?.shortCode ?? "",
                                      messageText: self.model?.data?.messageText ?? "")
    }
}

extension ParkingSMSCopyPresenter: ParkingSMSCopyPresenterProtocol {
    func openMessagesApp() {
        self.sendSMS()
    }
    func loadData() {
        self.view?.setupUI()
    }
}

extension ParkingSMSCopyPresenter: ParkingSMSCopyInteractorOutputProtocol {
    
}
