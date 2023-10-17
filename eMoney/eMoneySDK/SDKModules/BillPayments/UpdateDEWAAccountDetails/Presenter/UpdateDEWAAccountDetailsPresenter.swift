//
//  UpdateDEWAAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation

class UpdateDEWAAccountDetailsPresenter {

    // MARK: Properties

    weak var view: UpdateDEWAAccountDetailsViewProtocol?
    var router: UpdateDEWAAccountDetailsRouterProtocol?
    var interactor: UpdateDEWAAccountDetailsInteractorProtocol?
}

extension UpdateDEWAAccountDetailsPresenter: UpdateDEWAAccountDetailsPresenterProtocol {
    
    func loadData() {
    
    }
}

extension UpdateDEWAAccountDetailsPresenter: UpdateDEWAAccountDetailsInteractorOutputProtocol {
    
}
