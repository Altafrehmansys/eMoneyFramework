//
//  SelectCountryViewContract.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//  
//

import Foundation
protocol SelectCountryViewDelegate: AnyObject {
    func didSelectCountry(country: CountryCellModel)
}


protocol SelectCountryViewProtocol: ViperView {
    func reloadData()
}

protocol SelectCountryViewPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    func didStartSearch(text: String)
    func loadData()
    func didSelectCountry(index: Int)
}

protocol SelectCountryViewInteractorProtocol: ViperInteractor {
    func getCountries() async
}

protocol SelectCountryViewInteractorOutputProtocol: AnyObject {
    func getCountriesSuccess(data: CountriesResponse)
    func getCountiresFail(error: Error)
}

protocol SelectCountryViewRouterProtocol: ViperRouter {
    func go(to route: SelectCountryViewRouter.Route)
}
