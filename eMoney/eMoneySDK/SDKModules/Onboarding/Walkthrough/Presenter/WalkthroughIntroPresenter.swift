//
//  WalkthroughIntroPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 14/04/2023.
//  
//

import Foundation

class WalkthroughIntroPresenter {

    // MARK: Properties

    weak var view: WalkthroughIntroViewProtocol?
    var router: WalkthroughIntroRouterProtocol?
    var interactor: WalkthroughIntroInteractorProtocol?
}

extension WalkthroughIntroPresenter: WalkthroughIntroPresenterProtocol {
    func loadWalkthroughIntroData() {
        Loader.shared.showFullScreen()
        interactor?.getWalkThroughFromServer()
    }
    
    func navigateToRegisterMobileNumber() {
        print("loadWalkthroughIntroData called")
        router?.go(to: .navigateToRegisterMobile)
       
    }

    func navigateToLoginMobileNumber() {
        router?.go(to: .navigateToLoginMobile)
    }
}

extension WalkthroughIntroPresenter: WalkthroughIntroInteractorOutputProtocol {
    func walkThroughIntroRequestError(error: AppError) {
        Loader.shared.hideFullScreen()
        self.view?.walkThroughIntroRequestError(error: error)
    }
    
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel) {
        Loader.shared.hideFullScreen()
        self.view?.walkThroughIntroRequestResponse(response: response)
    }
    
}
