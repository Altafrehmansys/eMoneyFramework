//
//  DownloadAccountDetailsPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation

class DownloadAccountDetailsPresenter {

    // MARK: Properties

    weak var view: DownloadAccountDetailsViewProtocol?
    var router: DownloadAccountDetailsRouterProtocol?
    var interactor: DownloadAccountDetailsInteractorProtocol?
}

extension DownloadAccountDetailsPresenter: DownloadAccountDetailsPresenterProtocol {
    
    func loadData() {
    
    }
}

extension DownloadAccountDetailsPresenter: DownloadAccountDetailsInteractorOutputProtocol {
    
}
