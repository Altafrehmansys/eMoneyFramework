//
//  AddMoneyWebViewContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 01/05/2023.
//  
//

import Foundation

protocol AddMoneyWebViewViewProtocol: ViperView {
    var presenter: AddMoneyWebViewPresenterProtocol! { get set }
    
    func setupUI()
    func reloadWebView(isHidden: Bool)
    func stopLoading()
}

protocol AddMoneyWebViewPresenterProtocol: ViperPresenter {
    var request: URLRequest? { get set}
    var flowType: CashInFlowType { get set }
    
    func loadData()
    
    func extractData(from response: Dictionary<AnyHashable, Any>)
    func goBack()
}

protocol AddMoneyWebViewInteractorProtocol: ViperInteractor {
    
}

protocol AddMoneyWebViewInteractorOutputProtocol: AnyObject {
}

protocol AddMoneyWebViewRouterProtocol: ViperRouter {
    func go(to route: AddMoneyWebViewRouter.Route)
}
