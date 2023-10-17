//
//  CountrySelectionContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/05/2023.
//  
//

import Foundation

protocol CountrySelectionViewProtocol: ViperView {
    func onCounrtriesListResponse(countriesData:CountryListData)
    func onError(error: AppError)
}

protocol CountrySelectionPresenterProtocol: ViperPresenter {
    func loadData()
}

protocol CountrySelectionInteractorProtocol: ViperInteractor {
    func getCountries()
}

protocol CountrySelectionInteractorOutputProtocol: AnyObject {
    func onCounrtriesListResponse(response: CountryListResponseModel?)
    func onCounrtriesListError(error: AppError)
}

protocol CountrySelectionRouterProtocol: ViperRouter {
    func go(to route: CountrySelectionRouter.Route)
}
