//
//  LoginNumberContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/05/2023.
//  
//

import Foundation

protocol LoginNumberViewProtocol: ViperView {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel)
    func registerStatusRequestResponseError(error: AppError)
}

protocol LoginNumberPresenterProtocol: ViperPresenter {
    func checkMobileNumberStatus(msisdn : String)
    func navigateToVerify(msisdn : String)
}

protocol LoginNumberInteractorProtocol: ViperInteractor {
    func checkMobileNumberStatusFromServer(msisdn:String)
}

protocol LoginNumberInteractorOutputProtocol: AnyObject {
    func registerStatusRequestResponse(response: RegisterMobileNumberResponseModel)
    func registerStatusRequestResponseError(error: AppError)
}

protocol LoginNumberRouterProtocol: ViperRouter {
    func go(to route: LoginNumberRouter.Route)
}
