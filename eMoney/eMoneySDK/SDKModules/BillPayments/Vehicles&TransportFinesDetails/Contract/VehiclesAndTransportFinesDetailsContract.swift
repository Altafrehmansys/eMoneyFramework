//
//  VehiclesAndTransportFinesDetailsContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

protocol VehiclesAndTransportFinesDetailsViewProtocol: ViperView {
    
    var presenter: VehiclesAndTransportFinesDetailsPresenterProtocol! { get set }
    func setupUI()
    func reloadData()
}

protocol VehiclesAndTransportFinesDetailsPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var selectedItem:ListItems? { get set }
    var fine:VehicleTrafficFineDubaiPolice { get set }
    func loadData()
    func makeDataSource()
    func openTraficFineBottomSheet(_ service:ServiceDetail?)
    func navigateToAccountAmountDetail()
    var input:BillAccountDetailsParameters? { get set }
}

protocol VehiclesAndTransportFinesDetailsInteractorProtocol: ViperInteractor {
    
}

protocol VehiclesAndTransportFinesDetailsInteractorOutputProtocol: AnyObject {
}

protocol VehiclesAndTransportFinesDetailsRouterProtocol: ViperRouter {
    func go(to route: VehiclesAndTransportFinesDetailsRouter.Route)
}
