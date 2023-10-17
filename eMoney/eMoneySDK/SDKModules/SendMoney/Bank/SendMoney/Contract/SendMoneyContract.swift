//
//  SendMoneyContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation

protocol SendMoneyViewProtocol: ViperView {
    var presenter: SendMoneyPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
    
}

protocol SendMoneyPresenterProtocol: ViperPresenter {

    var dataSource: [StandardCellModel] { get }
    func loadData()
    func makeDataSource()
    
    func navigateToSendMoneyToBankAccount()
    func navigateToSendMoneyToAbroad()
    
    func navigateToQRCodeScan()
    
    func loadAllBeneficiaries()

}

protocol SendMoneyInteractorProtocol: ViperInteractor {
    
}

protocol SendMoneyInteractorOutputProtocol: AnyObject {
    
}

protocol SendMoneyRouterProtocol: ViperRouter {
    func go(to route: SendMoneyRouter.Route)
}
