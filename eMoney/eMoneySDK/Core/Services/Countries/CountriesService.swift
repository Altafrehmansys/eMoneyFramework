//
//  CountriesService.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 12/06/2023.
//

import Foundation

protocol CountryServiceProcotol: AnyObject {
    func getCountries() async throws -> CountriesResponse?
}

final class CountryService: CountryServiceProcotol {
    
    func getCountries() async throws -> CountriesResponse? {
        do {
            let response: CountriesResponse? = try await ApiManager.shared.execute(CommonAPIRouter.getCountries)
            return response
        } catch let error as AppError {
            throw(error)
        }
    }
}
