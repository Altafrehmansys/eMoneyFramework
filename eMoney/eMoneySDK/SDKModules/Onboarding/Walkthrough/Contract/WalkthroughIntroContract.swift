//
//  WalkthroughIntroContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 14/04/2023.
//  
//

import Foundation

protocol WalkthroughIntroViewProtocol: ViperView {
    func walkThroughIntroRequestError(error: AppError)
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel)
}

protocol WalkthroughIntroPresenterProtocol: ViperPresenter {
    func loadWalkthroughIntroData()
    func navigateToRegisterMobileNumber()
    func navigateToLoginMobileNumber()
}

protocol WalkthroughIntroInteractorProtocol: ViperInteractor {
    func getWalkThroughFromServer()
}

protocol WalkthroughIntroInteractorOutputProtocol: AnyObject {
    
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel)
    func walkThroughIntroRequestError(error: AppError)
    
}

protocol WalkthroughIntroRouterProtocol: ViperRouter {
    func go(to route: WalkthroughIntroRouter.Route)
}
