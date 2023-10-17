//
//  MobileBillPaymentSuccessfullContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation

protocol MobileBillPaymentSuccessfullViewProtocol: ViperView {
    
    var presenter: MobileBillPaymentSuccessfullPresenterProtocol! { get set }
    func setUpUI()
    func reloadData()
    
}

protocol MobileBillPaymentSuccessfullPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get set }
    var isCollapsed: Bool { get set }
    func loadData()
    func makeDataSource()
    
  //  func moveToHomeScreen()
}

protocol MobileBillPaymentSuccessfullInteractorProtocol: ViperInteractor {
    
}

protocol MobileBillPaymentSuccessfullInteractorOutputProtocol: AnyObject {
}

protocol MobileBillPaymentSuccessfullRouterProtocol: ViperRouter {
    func go(to route: MobileBillPaymentSuccessfullRouter.Route)
}
