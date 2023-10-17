//
//  PaymentMachinesContract.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//  
//

import Foundation

protocol PaymentMachinesViewProtocol: ViperView {
    var presenter: PaymentMachinesPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()

}

protocol PaymentMachinesPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var getLocationNearByType: String { get set }
    func loadData()
    func makeDataSource()

}

protocol PaymentMachinesInteractorProtocol: ViperInteractor {
    
}

protocol PaymentMachinesInteractorOutputProtocol: AnyObject {
}

protocol PaymentMachinesRouterProtocol: ViperRouter {
    func go(to route: PaymentMachinesRouter.Route)
}
