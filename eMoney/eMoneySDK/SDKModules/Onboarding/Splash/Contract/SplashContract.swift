//
//  SplashContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/05/2023.
//  
//

import Foundation

protocol SplashViewProtocol: ViperView {
    func onCheckAppVersionResponse(data:CheckAppVersionData)
    func showLanguageSelection()
}

protocol SplashPresenterProtocol: ViperPresenter {
    func loadData()
    func checkStatus()
    func navigateToSelectLanguage()
}

protocol SplashInteractorProtocol: ViperInteractor {
    func checkAppVersion()
}

protocol SplashInteractorOutputProtocol: AnyObject {
    func onCheckAppVersionResponse(response:CheckAppVersionResponseModel?)
    func onCheckAppVersionError(error:AppError)
}

protocol SplashRouterProtocol: ViperRouter {
    func go(to route: SplashRouter.Route)
}
