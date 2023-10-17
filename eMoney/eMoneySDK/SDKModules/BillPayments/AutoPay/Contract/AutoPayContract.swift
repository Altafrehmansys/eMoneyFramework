//
//  AutoPayContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import Foundation

protocol AutoPayViewProtocol: ViperView {
    
}

protocol AutoPayPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol AutoPayInteractorProtocol: ViperInteractor {
    
}

protocol AutoPayInteractorOutputProtocol: AnyObject {
}

protocol AutoPayRouterProtocol: ViperRouter {
    func go(to route: AutoPayRouter.Route)
}
