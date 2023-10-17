//
//  ParkingSMSCopyContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//  
//

import Foundation

protocol ParkingSMSCopyViewProtocol: ViperView {
    func setupUI()
}

protocol ParkingSMSCopyPresenterProtocol: ViperPresenter {
    func loadData()
    func openMessagesApp()
    var model:ParkingSMSCopyResponseModel? {get}
}

protocol ParkingSMSCopyInteractorProtocol: ViperInteractor {
    
}

protocol ParkingSMSCopyInteractorOutputProtocol: AnyObject {
}

protocol ParkingSMSCopyRouterProtocol: ViperRouter {
    func go(to route: ParkingSMSCopyRouter.Route)
}
