//
//  IMTSendMoneyContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//  
//

import Foundation

protocol IMTSendMoneyViewProtocol: ViperView {
    func reloadData(data:[StandardCellModel])
}

protocol IMTSendMoneyPresenterProtocol: ViperPresenter {
    func loadData()
    var selectedCountry:Countries? { get set }
}

protocol IMTSendMoneyInteractorProtocol: ViperInteractor {
    
}

protocol IMTSendMoneyInteractorOutputProtocol: AnyObject {
}

protocol IMTSendMoneyRouterProtocol: ViperRouter {
    func go(to route: IMTSendMoneyRouter.Route)
}
