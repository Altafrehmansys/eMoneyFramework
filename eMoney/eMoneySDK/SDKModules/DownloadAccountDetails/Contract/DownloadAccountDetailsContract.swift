//
//  DownloadAccountDetailsContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 07/06/2023.
//  
//

import Foundation

protocol DownloadAccountDetailsViewProtocol: ViperView {
    
}

protocol DownloadAccountDetailsPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol DownloadAccountDetailsInteractorProtocol: ViperInteractor {
    
}

protocol DownloadAccountDetailsInteractorOutputProtocol: AnyObject {
}

protocol DownloadAccountDetailsRouterProtocol: ViperRouter {
    func go(to route: DownloadAccountDetailsRouter.Route)
}
