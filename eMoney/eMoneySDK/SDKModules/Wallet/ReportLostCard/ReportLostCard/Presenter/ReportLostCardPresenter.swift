//
//  ReportLostCardPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 14/07/2023.
//  
//

import Foundation

class ReportLostCardPresenter {

    // MARK: Properties

    weak var view: ReportLostCardViewProtocol?
    var router: ReportLostCardRouterProtocol?
    var interactor: ReportLostCardInteractorProtocol?
}

extension ReportLostCardPresenter: ReportLostCardPresenterProtocol {
    
    func loadData() {
    
    }
}

extension ReportLostCardPresenter: ReportLostCardInteractorOutputProtocol {
    
}

extension ReportLostCardPresenter{
    func presentReportCardSuccessScreen() {
        self.router?.go(to: .presentReportCardSuccessScreen)
    }
}
