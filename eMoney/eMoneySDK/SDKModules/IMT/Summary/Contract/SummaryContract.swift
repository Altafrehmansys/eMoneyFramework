//
//  SummaryContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

protocol SummaryViewProtocol: ViperView {
    func setupUI()
    func reloadData()
}

protocol SummaryPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func viewDidLoad()
    func makeDataSource()
    func showSenderDetails()
    func showFraudWarnings()
    func navigateToOtpOnConfirmTapped()
    func navigateToSuccessTransfer()
    
}

protocol SummaryInteractorProtocol: ViperInteractor {
    
}

protocol SummaryInteractorOutputProtocol: AnyObject {
}

protocol SummaryRouterProtocol: ViperRouter {
    func go(to route: SummaryRouter.Route)
}
