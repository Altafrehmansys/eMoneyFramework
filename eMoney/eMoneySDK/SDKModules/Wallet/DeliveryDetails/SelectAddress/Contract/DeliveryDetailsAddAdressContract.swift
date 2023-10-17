//
//  DeliveryDetailsAddAdressContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

protocol DeliveryDetailsAddAdressViewProtocol: ViperView {
    
}

protocol DeliveryDetailsAddAdressPresenterProtocol: ViperPresenter {
    func loadData()
    func didTapConfirmButton()
}

protocol DeliveryDetailsAddAdressInteractorProtocol: ViperInteractor {
    
}

protocol DeliveryDetailsAddAdressInteractorOutputProtocol: AnyObject {
}

protocol DeliveryDetailsAddAdressRouterProtocol: ViperRouter {
    func go(to route: DeliveryDetailsAddAdressRouter.Route)
}
