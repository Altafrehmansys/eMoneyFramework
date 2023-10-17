//
//  DEWAOfficePresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

class DEWAOfficePresenter {

    // MARK: Properties

    weak var view: DEWAOfficeViewProtocol?
    var router: DEWAOfficeRouterProtocol?
    var interactor: DEWAOfficeInteractorProtocol?
}

extension DEWAOfficePresenter: DEWAOfficePresenterProtocol {
    
    func loadData() {
    
    }
    
    func didTapAutoPayButton() {
        let inputs = 
        router?.go(to: .autoPayBottomSheet(inputs: nil))
    }
}

extension DEWAOfficePresenter: DEWAOfficeInteractorOutputProtocol {
    
}
