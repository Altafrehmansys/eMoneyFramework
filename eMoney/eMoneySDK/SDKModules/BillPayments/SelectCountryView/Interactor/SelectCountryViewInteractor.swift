//
//  SelectCountryViewInteractor.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//  
//

import Foundation

class SelectCountryViewInteractor {
    // MARK: Properties

    weak var output: SelectCountryViewInteractorOutputProtocol?
    var service: CountryServiceProcotol?

}

extension SelectCountryViewInteractor: SelectCountryViewInteractorProtocol {
    //Implement your services
    
    func getCountries() async {
        do {
            let countriesResponse =  try await service?.getCountries()
            guard let countriesResponse = countriesResponse else { return }
            output?.getCountriesSuccess(data: countriesResponse)
        } catch {
            output?.getCountiresFail(error: error)
        }
        
    }
}
