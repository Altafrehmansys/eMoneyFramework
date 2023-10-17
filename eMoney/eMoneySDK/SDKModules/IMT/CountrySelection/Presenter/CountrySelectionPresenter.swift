//
//  CountrySelectionPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/05/2023.
//  
//

import Foundation

class CountrySelectionPresenter {

    // MARK: Properties

    weak var view: CountrySelectionViewProtocol?
    var router: CountrySelectionRouterProtocol?
    var interactor: CountrySelectionInteractorProtocol?
}

extension CountrySelectionPresenter: CountrySelectionPresenterProtocol {
    
    func loadData() {
        getCountriesListRequest()
    }
    
    private func getCountriesListRequest() {
        Loader.shared.showFullScreen()
        interactor?.getCountries()
    }
}

extension CountrySelectionPresenter: CountrySelectionInteractorOutputProtocol {
    
    func onCounrtriesListResponse(response: CountryListResponseModel?) {
        Loader.shared.hideFullScreen()
        if let data = response?.data{
            view?.onCounrtriesListResponse(countriesData: data)
        }
    }
    func onCounrtriesListError(error: AppError) {
        Loader.shared.hideFullScreen()
        view?.onError(error: error)
    }
    
}
