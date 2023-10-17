//
//  SelectProviderViewContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation

// This protocol is a delegate to handle if user did select provider

protocol SelectProviderViewDelegate: AnyObject {
    func didSelectProvider(provider: ProviderCellModel)
}

protocol SelectProviderViewProtocol: ViperView {
    func reloadData()
}

protocol SelectProviderViewPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func didSelectProvider(index: Int)
}

protocol SelectProviderViewInteractorProtocol: ViperInteractor {
    func getNetworkProviders(countryCode: String) async
}

protocol SelectProviderViewInteractorOutputProtocol: AnyObject {
    func getProvidersSuccess(data: NetworkProvidersResponse)
    func getProvidersFail(error: Error)
}

protocol SelectProviderViewRouterProtocol: ViperRouter {
    func go(to route: SelectProviderViewRouter.Route)
}
