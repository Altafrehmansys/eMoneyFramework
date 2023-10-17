//
//  SelectCountryViewPresenter.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//  
//

import Foundation

class SelectCountryViewPresenter {

    // MARK: Properties

    weak var view: SelectCountryViewProtocol?
    var router: SelectCountryViewRouterProtocol?
    var interactor: SelectCountryViewInteractorProtocol?
    weak var delegate: SelectCountryViewDelegate?

    var dataSource: [StandardCellModel] = []
    var tempDataSource: [StandardCellModel] = []

}

extension SelectCountryViewPresenter: SelectCountryViewPresenterProtocol {
    func didStartSearch(text: String) {
        if !text.isEmpty {
            dataSource =  tempDataSource.filter ({
                if let country = $0 as? CountryCellModel {
                    return country.name.lowercased().contains(text.lowercased())
                }
                return false
            })
        } else {
            dataSource = tempDataSource
        }

        self.view?.reloadData()
    }
    
    
    func loadData() {
       // getDatasurce()
        Task {
            await interactor?.getCountries()
        }
    }
    
    
    func didSelectCountry(index: Int) {
        let country = dataSource[index]
        guard let country = country as? CountryCellModel  else { return }
        delegate?.didSelectCountry(country: country)
        router?.go(to: .dimiss)
    }
    
    private func getDatasurce(countries: [CountryData]) {
        var datasource = [StandardCellModel]()
        datasource = countries.map({  return CountryCellModel(name: $0.countryName ?? "", image: CountriesMapping(rawValue: $0.countryISO ?? "")?.countryFlag ?? "", iso: $0.countryISO ?? "", codes: $0.countryCodeList) })
        self.dataSource = datasource
        self.tempDataSource = datasource
    }
    
}

extension SelectCountryViewPresenter: SelectCountryViewInteractorOutputProtocol {
    func getCountriesSuccess(data: CountriesResponse) {
        self.getDatasurce(countries: data.data)
        self.view?.reloadData()
    }
    
    func getCountiresFail(error: Error) {
        
    }
}
