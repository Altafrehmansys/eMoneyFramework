//
//  WalletInteractor.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation

class WalletInteractor {
    // MARK: Properties

    weak var output: WalletInteractorOutputProtocol?
    private let service: WalletServicesProtocol?
    
    init(service: WalletServicesProtocol?) {
        self.service = service
    }

}

extension WalletInteractor: WalletInteractorProtocol {
    //Implement your services
    
    func getBankAccounts() {
        Task {
            try await self.service?.getBanksAccounts()
        }
    }
    
    func getCards() {
        
    }
}
