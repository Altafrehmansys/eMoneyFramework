//
//  WalletBankService.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//

import Foundation

protocol WalletServicesProtocol: AnyObject {
    func getBanksAccounts() async throws -> WalletBankAccountResponse?
    func getCards() async throws -> NetworkProvidersResponse?
}

final class  WalletServices: WalletServicesProtocol {

    func getBanksAccounts() async throws -> WalletBankAccountResponse? {
        do {
            let response: WalletBankAccountResponse? = try await ApiManager.shared.execute(WalletAPIRouter.getBankAccounts)
            return response
        } catch let error as AppError {
            throw(error)
        }
    }
    
    func getCards() async throws -> NetworkProvidersResponse? {
        do {
            let response: NetworkProvidersResponse? = try await ApiManager.shared.execute(WalletAPIRouter.getCards)
            return response
        } catch let error as AppError {
            throw(error)
        }
    }
}
