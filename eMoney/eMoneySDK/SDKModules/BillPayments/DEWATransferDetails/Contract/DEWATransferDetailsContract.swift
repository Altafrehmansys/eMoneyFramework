//
//  DEWATransferDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 06/06/2023.
//  
//

import Foundation

protocol DEWATransferDetailsViewProtocol: ViperView {
    
}

protocol DEWATransferDetailsPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol DEWATransferDetailsInteractorProtocol: ViperInteractor {
    
}

protocol DEWATransferDetailsInteractorOutputProtocol: AnyObject {
}

protocol DEWATransferDetailsRouterProtocol: ViperRouter {
    func go(to route: DEWATransferDetailsRouter.Route)
}
