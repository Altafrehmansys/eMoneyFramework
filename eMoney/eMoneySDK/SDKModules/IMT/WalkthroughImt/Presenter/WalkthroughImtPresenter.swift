//
//  WalkthroughImtPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation

class WalkthroughImtPresenter {

    // MARK: Properties

    weak var view: WalkthroughImtViewProtocol?
    var router: WalkthroughImtRouterProtocol?
    var interactor: WalkthroughImtInteractorProtocol?
}

extension WalkthroughImtPresenter: WalkthroughImtPresenterProtocol {
    
    func loadWalkthroughIntroData() {
        Loader.shared.showFullScreen()
        interactor?.getWalkThroughFromServer()
    }
   
    func navigateToStartSending() {
        print("loadWalkthroughIntroData called")
        router?.go(to: .startSending)
    }
    func navigateToWatchtutorial() {
        router?.go(to: .watchTutorial)
    }
}

extension WalkthroughImtPresenter: WalkthroughImtInteractorOutputProtocol {
    func walkThroughIntroRequestError(error: AppError) {
        Loader.shared.hideFullScreen()
        self.view?.walkThroughIntroRequestError(error: error)
    }
    
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel) {
        Loader.shared.hideFullScreen()
        self.view?.walkThroughIntroRequestResponse(response: response)
    }
}
