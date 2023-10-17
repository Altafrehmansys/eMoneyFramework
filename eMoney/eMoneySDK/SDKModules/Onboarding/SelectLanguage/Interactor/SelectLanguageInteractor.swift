//
//  SelectLanguageInteractor.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//  
//

import Foundation

class SelectLanguageInteractor {
    // MARK: Properties

    weak var output: SelectLanguageInteractorOutputProtocol?

}

extension SelectLanguageInteractor: SelectLanguageInteractorProtocol {
    
    //Implement your services
    func getLanguages() {
        Task{
            do {
                //let request = WalkthroughRequestModel(screenName: "TUTORIAL SCREEN", sourcePlatform: "CONSUMER APP SCREENS")
                
                let langData:LanguagesResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.allLanguages)
                
                await MainActor.run{
                    output?.onFetchLanguageResponse(response: langData?.data ?? [])
                }
            
            } catch let error as AppError {
                await MainActor.run{
                    //send success for temporary
//                    let lang:LanguagesResponseModel = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.decode("allLanguagesResponse.json")
//                    output?.onFetchLanguageResponse(response: lang.data ?? [])
                    output?.onFetchLanguageError(error: error)
                }
                print(error.errorDescription)
            }
        }
    }
}
