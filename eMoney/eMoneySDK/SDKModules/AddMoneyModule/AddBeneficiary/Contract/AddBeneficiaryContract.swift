//
//  AddBeneficiaryContract.swift
//  e&money
//
//  Created by Qamar Iqbal on 15/06/2023.
//  
//

import Foundation

protocol AddBeneficiaryViewProtocol: ViperView {
    var presenter: AddBeneficiaryPresenterProtocol! { get set }
    func setupUI()
}

protocol AddBeneficiaryPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol AddBeneficiaryInteractorProtocol: ViperInteractor {
    
}

protocol AddBeneficiaryInteractorOutputProtocol: AnyObject {
}

protocol AddBeneficiaryRouterProtocol: ViperRouter {
    func go(to route: AddBeneficiaryRouter.Route)
}
