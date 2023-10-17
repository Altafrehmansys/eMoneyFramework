//
//  AutoPayPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

class AutoPayPresenter {

    // MARK: Properties

    weak var view: AutoPayViewProtocol?
    var router: AutoPayRouterProtocol?
    var interactor: AutoPayInteractorProtocol?
}

extension AutoPayPresenter: AutoPayPresenterProtocol {
    
    func loadData() {
    
    }
}

extension AutoPayPresenter: AutoPayInteractorOutputProtocol {
    
}
