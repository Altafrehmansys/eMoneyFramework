//
//  ReEnterYourPINPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/07/2023.
//  
//

import Foundation

class ReEnterYourPINPresenter {

    // MARK: Properties

    weak var view: ReEnterYourPINViewProtocol?
    var router: ReEnterYourPINRouterProtocol?
    var interactor: ReEnterYourPINInteractorProtocol?
}

extension ReEnterYourPINPresenter: ReEnterYourPINPresenterProtocol {
    
    func loadData() {
    
    }
    
    func changePinRequest(pin: String, newPin: String) {
        var request = ReEnterYourPINRequestModel()
//        let pinVal = try? pin.aesEncrypt(key:EncryptionKey.pinKey)
        let newPinVal = try? newPin.aesEncrypt(key:EncryptionKey.pinKey)
        request.pin = pin
        request.currentPin = pin
        request.newPin = newPinVal
        request.repeatNewPin = newPinVal
        Loader.shared.showFullScreen()
        interactor?.changePinRequest(request: request)
    }
}

extension ReEnterYourPINPresenter: ReEnterYourPINInteractorOutputProtocol {
    func onChangePinResponse(response:ReEnterYourPINResponseModel?) {
        Loader.shared.hideFullScreen()
        router?.go(to: .successPinChange)
    }
    
    func onChangePinError(error:AppError) {
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
        Loader.shared.hideFullScreen()
    }
}
