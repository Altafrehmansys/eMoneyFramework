//
//  BillSelectProviderContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation

protocol BillSelectProviderViewProtocol: ViperView {
    func setUI()
    func updateCountry(name: String)
    func updateProvider(name: String)
    func enableNextButton()
    func disableNextButton()
}

protocol BillSelectProviderPresenterProtocol: ViperPresenter {
    
    var navTitle:String { get set }
    var selectItemType:BillsAnsTopUpType { get set }
    
    func loadData()
    func didTapSelectCountry()
    func didTapSelectProvider()
    func didTapNextButton()
}

protocol BillSelectProviderInteractorProtocol: ViperInteractor {
    func getCountries()
    func getNetworkProviders()
}

protocol BillSelectProviderInteractorOutputProtocol: AnyObject {
}

protocol BillSelectProviderRouterProtocol: ViperRouter {
    func go(to route: BillSelectProviderRouter.Route)
}
