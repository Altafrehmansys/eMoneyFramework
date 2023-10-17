//
//  ReportLostCardContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation

protocol ReportLostCardViewProtocol: ViperView {
    
}

protocol ReportLostCardPresenterProtocol: ViperPresenter {
    func loadData()
    
    func presentReportCardSuccessScreen()
}

protocol ReportLostCardInteractorProtocol: ViperInteractor {
    
}

protocol ReportLostCardInteractorOutputProtocol: AnyObject {
}

protocol ReportLostCardRouterProtocol: ViperRouter {
    func go(to route: ReportLostCardRouter.Route)
}
