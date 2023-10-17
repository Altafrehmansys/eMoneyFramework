//
//  SelectProviderViewInteractor.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation

class SelectProviderViewInteractor {
    // MARK: Properties
    
    weak var output: SelectProviderViewInteractorOutputProtocol?
    var service: NetworkProvidersServiceProtocol?
}

extension SelectProviderViewInteractor: SelectProviderViewInteractorProtocol {
    //Implement your services
    
    func getNetworkProviders(countryCode: String) async {
        do {
            let providersResponse =  try await service?.getProviders(countryCode: countryCode)
            guard let providersResponse = providersResponse else { return }
            output?.getProvidersSuccess(data: providersResponse)
        } catch {
            output?.getProvidersFail(error: error)
        }
    }
}
