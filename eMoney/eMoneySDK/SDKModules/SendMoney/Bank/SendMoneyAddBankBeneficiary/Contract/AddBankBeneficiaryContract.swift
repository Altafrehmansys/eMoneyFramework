//
//  AddBankBeneficiaryContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation

protocol AddBankBeneficiaryViewProtocol: ViperView {
    
    var presenter: AddBankBeneficiaryPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol AddBankBeneficiaryPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    func navigateToAddNewBeneficiary()
    func navigateToAddedBeneficiaryDetails()
}

protocol AddBankBeneficiaryInteractorProtocol: ViperInteractor {
    
}

protocol AddBankBeneficiaryInteractorOutputProtocol: AnyObject {
}

protocol AddBankBeneficiaryRouterProtocol: ViperRouter {
    func go(to route: AddBankBeneficiaryRouter.Route)
}
