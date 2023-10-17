//
//  WalkthroughImtContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation

protocol WalkthroughImtViewProtocol: ViperView {
    func walkThroughIntroRequestError(error: AppError)
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel)
}

protocol WalkthroughImtPresenterProtocol: ViperPresenter {
    func loadWalkthroughIntroData()
    func navigateToStartSending()
    func navigateToWatchtutorial()
}

protocol WalkthroughImtInteractorProtocol: ViperInteractor {
    func getWalkThroughFromServer()
}

protocol WalkthroughImtInteractorOutputProtocol: AnyObject {
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel)
    func walkThroughIntroRequestError(error: AppError)
}

protocol WalkthroughImtRouterProtocol: ViperRouter {
    func go(to route: WalkthroughImtRouter.Route)
}
