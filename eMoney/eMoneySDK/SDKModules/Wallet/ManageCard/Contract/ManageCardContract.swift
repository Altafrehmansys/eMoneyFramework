//
//  ManageCardContract.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//  
//

import Foundation

protocol ManageCardViewProtocol: ViperView {
    func setupUI()
    func reloadTableView()
}

protocol ManageCardPresenterProtocol: ViperPresenter {
    var dataSource:[StandardCellModel] {get}
    func loadData()
    func navigateToOrderCard()
    func navigateToChangeCardPIN()
    func navigateToReportLostCard()
    func loadCancelCardBottomsheet()
    func navigateToCancelCard()
    func navigateToCarsAccountLimits()
    func loadFreezCardBottomSheet()
    func loadAddAutoMoneyBottomSheet()
}

protocol ManageCardInteractorProtocol: ViperInteractor {
    
}

protocol ManageCardInteractorOutputProtocol: AnyObject {
}

protocol ManageCardRouterProtocol: ViperRouter {
    func go(to route: ManageCardRouter.Route)
}
