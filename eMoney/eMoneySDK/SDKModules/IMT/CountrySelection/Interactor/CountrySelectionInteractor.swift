//
//  CountrySelectionInteractor.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/05/2023.
//  
//

import Foundation

class CountrySelectionInteractor {
    // MARK: Properties

    weak var output: CountrySelectionInteractorOutputProtocol?

}

extension CountrySelectionInteractor: CountrySelectionInteractorProtocol {
    
    //Implement your services
    func getCountries() {
        Task{
            do {
                
                let response:CountryListResponseModel? = try await ApiManager.shared.execute(IMTApiRouter.getCountrie)
                
                await MainActor.run{
                    output?.onCounrtriesListResponse(response: response)
                }
            
            } catch let error as AppError {
                await MainActor.run{
                    output?.onCounrtriesListError(error: error)
                }
                print(error.errorDescription)
            }
        }
    }
}
