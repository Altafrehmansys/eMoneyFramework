//
//  SplashInteractor.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/05/2023.
//  
//

import Foundation

class SplashInteractor {
    // MARK: Properties

    weak var output: SplashInteractorOutputProtocol?

}

extension SplashInteractor: SplashInteractorProtocol {
    //Implement your services
    func checkAppVersion() {
        Task{
            do {
                let data:CheckAppVersionResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.checkAppVersion)
                await MainActor.run{
                    output?.onCheckAppVersionResponse(response:data)
                }
            } catch let error as AppError {
                print(error.errorDescription)
                await MainActor.run{
                    output?.onCheckAppVersionError(error:error)
                }
            }
        }
    }
}
