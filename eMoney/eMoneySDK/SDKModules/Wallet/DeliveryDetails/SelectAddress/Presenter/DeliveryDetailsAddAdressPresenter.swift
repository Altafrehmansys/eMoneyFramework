//
//  DeliveryDetailsAddAdressPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//  
//

import Foundation

class DeliveryDetailsAddAdressPresenter {

    // MARK: Properties

    weak var view: DeliveryDetailsAddAdressViewProtocol?
    var router: DeliveryDetailsAddAdressRouterProtocol?
    var interactor: DeliveryDetailsAddAdressInteractorProtocol?
}

extension DeliveryDetailsAddAdressPresenter: DeliveryDetailsAddAdressPresenterProtocol {
    
    func loadData() {
    
    }
    
    func didTapConfirmButton() {
        router?.go(to: .confirmPay)
    }
}

extension DeliveryDetailsAddAdressPresenter: DeliveryDetailsAddAdressInteractorOutputProtocol {
    
}
