//
//  AddBeneficiaryPresenter.swift
//  e&money
//
//  Created by Qamar Iqbal on 15/06/2023.
//  
//

import Foundation

class AddBeneficiaryPresenter {
    weak var view: AddBeneficiaryViewProtocol?
    var router: AddBeneficiaryRouterProtocol?
    var interactor: AddBeneficiaryInteractorProtocol?
}

extension AddBeneficiaryPresenter: AddBeneficiaryPresenterProtocol {
    func loadData() {
        view?.setupUI()
    }
}

extension AddBeneficiaryPresenter: AddBeneficiaryInteractorOutputProtocol {}

// MARK: - Setup Cells Actions
extension AddBeneficiaryPresenter {
    
    func openShareMenu() {
        // Share Menu
    }
    
    func cancelView() {
        // Cancel View
    }
    
    
}
