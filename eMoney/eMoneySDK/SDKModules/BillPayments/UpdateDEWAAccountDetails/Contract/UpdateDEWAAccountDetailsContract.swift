//
//  UpdateDEWAAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation

protocol UpdateDEWAAccountDetailsViewProtocol: ViperView {
    
}

protocol UpdateDEWAAccountDetailsPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol UpdateDEWAAccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol UpdateDEWAAccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol UpdateDEWAAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: UpdateDEWAAccountDetailsRouter.Route)
}
