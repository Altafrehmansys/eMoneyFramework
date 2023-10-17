//
//  DEWAOfficeContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

protocol DEWAOfficeViewProtocol: ViperView {
    
}

protocol DEWAOfficePresenterProtocol: ViperPresenter {
    func loadData()
    func didTapAutoPayButton()
}

protocol DEWAOfficeInteractorProtocol: ViperInteractor {
    
}

protocol DEWAOfficeInteractorOutputProtocol: AnyObject {
}

protocol DEWAOfficeRouterProtocol: ViperRouter {
    func go(to route: DEWAOfficeRouter.Route)
}
