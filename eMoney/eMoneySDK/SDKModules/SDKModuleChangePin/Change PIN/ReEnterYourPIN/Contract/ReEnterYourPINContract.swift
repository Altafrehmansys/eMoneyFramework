//
//  ReEnterYourPINContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

protocol ReEnterYourPINViewProtocol: ViperView {
    
}

protocol ReEnterYourPINPresenterProtocol: ViperPresenter {
    func loadData()
    func changePinRequest(pin: String, newPin: String)
}

protocol ReEnterYourPINInteractorProtocol: ViperInteractor {
    func changePinRequest(request:ReEnterYourPINRequestModel)
}

protocol ReEnterYourPINInteractorOutputProtocol: AnyObject {
    func onChangePinResponse(response:ReEnterYourPINResponseModel?)
    func onChangePinError(error:AppError)
}

protocol ReEnterYourPINRouterProtocol: ViperRouter {
    func go(to route: ReEnterYourPINRouter.Route)
}
