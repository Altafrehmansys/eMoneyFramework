//
//  AddMoneyScanCardPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 07/05/2023.
//  
//

import Foundation

class AddMoneyScanCardPresenter {

    // MARK: Properties

    weak var view: AddMoneyScanCardViewProtocol?
    var router: AddMoneyScanCardRouterProtocol?
    var interactor: AddMoneyScanCardInteractorProtocol?
}

// MARK: - Class Methods
extension AddMoneyScanCardPresenter: AddMoneyScanCardPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
    }
}

// MARK: - Navigations
extension AddMoneyScanCardPresenter {
    func sendBack(cardDetails: CardDetails) {
        router?.go(to: .didReturn(cardDetails: cardDetails))
    }
}

extension AddMoneyScanCardPresenter: AddMoneyScanCardInteractorOutputProtocol {
    
}
