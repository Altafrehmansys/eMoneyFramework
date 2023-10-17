//
//  DEWATransferDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 06/06/2023.
//  
//

import Foundation

class DEWATransferDetailsPresenter {

    // MARK: Properties

    weak var view: DEWATransferDetailsViewProtocol?
    var router: DEWATransferDetailsRouterProtocol?
    var interactor: DEWATransferDetailsInteractorProtocol?
}

extension DEWATransferDetailsPresenter: DEWATransferDetailsPresenterProtocol {
    
    func loadData() {
    
    }
}

extension DEWATransferDetailsPresenter: DEWATransferDetailsInteractorOutputProtocol {
    
}
