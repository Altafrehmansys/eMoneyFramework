//
//  AgentsAndMachineInteractor.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//  
//

import Foundation

class AgentsAndMachineInteractor {
    // MARK: Properties
    weak var output: AgentsAndMachineInteractorOutputProtocol?
}

extension AgentsAndMachineInteractor: AgentsAndMachineInteractorProtocol {
    //Implement your services
    func getLocationsList(request: GetLocationListModel){
        Task{
            do {
                let response: AgentsAndMachineResponseModel? = try await ApiManager.shared.execute(AddMoneyApiRouter.getLocationsList(param: request))
                await MainActor.run{
                    output?.onLocationsListResponse(response: response)
                }
            }
            catch let error as AppError {
                await MainActor.run{
                    output?.onFetchAgentsError(error: error)
                }
                print(error.errorDescription)
            }  
        }
    }
}
