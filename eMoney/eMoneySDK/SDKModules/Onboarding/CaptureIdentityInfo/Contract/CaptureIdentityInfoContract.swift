//
//  CaptureIdentityInfoContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/04/2023.
//  
//

import Foundation

protocol CaptureIdentityInfoViewProtocol: ViperView {
    func reloadData()
}

protocol CaptureIdentityInfoPresenterProtocol: ViperPresenter {
    var isScreenTypeSelfi: Bool { get set }
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func moveToEidScanScreen()
    func moveToLivenessCheck()
}

protocol CaptureIdentityInfoInteractorProtocol: ViperInteractor {
    
}

protocol CaptureIdentityInfoInteractorOutputProtocol: AnyObject {
}

protocol CaptureIdentityInfoRouterProtocol: ViperRouter {
    func go(to route: CaptureIdentityInfoRouter.Route)
}
