//
//  WalkthroughImtInteractor.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation

class WalkthroughImtInteractor {
    // MARK: Properties

    weak var output: WalkthroughImtInteractorOutputProtocol?

}

extension WalkthroughImtInteractor: WalkthroughImtInteractorProtocol {
   
    func getWalkThroughFromServer() {
        Task {
            do {
                let request = WalkthroughRequestModel(screenName: "TUTORIAL SCREEN APPREVAMP", sourcePlatform: "CONSUMER APP SCREENS APPREVAMP")
                let addPostObject:WalkthroughIntroResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.walkthrough(param: request))
                print(addPostObject ?? "")
                await MainActor.run {
                    if addPostObject != nil {
                        output?.walkThroughIntroRequestResponse(response:addPostObject!)
                    }
                }
            } catch let error as AppError {
                print(error.localizedDescription)
                await MainActor.run {
                    output?.walkThroughIntroRequestError(error: error)
                }
                
            }
        }
    }
}
