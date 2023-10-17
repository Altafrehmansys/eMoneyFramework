//
//  NetworkProvidersService.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 14/06/2023.
//

import Foundation

protocol NetworkProvidersServiceProtocol: AnyObject {
    func getProviders(countryCode: String) async throws -> NetworkProvidersResponse?
}

final class NetworkProvidersService: NetworkProvidersServiceProtocol {
    
    func getProviders(countryCode: String) async throws -> NetworkProvidersResponse? {
        do {
            let response: NetworkProvidersResponse? = try await ApiManager.shared.execute(CommonAPIRouter.getNetworkProviders(countryCode: countryCode))
            return response
        } catch let error as AppError {
            throw(error)
        }
    }
}
