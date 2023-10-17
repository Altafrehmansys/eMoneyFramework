//
//  HomeScreenInteractor.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import Foundation

final class HomeScreenInteractor {
    // MARK: - Attributes
    weak var output: HomeScreenInteractorOutputProtocol?
}

extension HomeScreenInteractor: HomeScreenInteractorProtocol {
    //Implement your services
    func getAvailableBalance() {
        Task {
            do {
                let response:AvailableBalanceResponse? = try await ApiManager.shared.execute(HomeApiRouter.availableBalance)
                await MainActor.run {
                    output?.onAvailableBalanceResponse(response: response)
                }
                
            } catch let error as AppError {
                await MainActor.run {
                    output?.onAvailableBalanceError(error:error)
                }
            }
        }
    }
  
}
