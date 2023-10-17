//
//  SplashPresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/05/2023.
//  
//

import Foundation

class SplashPresenter {

    // MARK: Properties

    weak var view: SplashViewProtocol?
    var router: SplashRouterProtocol?
    var interactor: SplashInteractorProtocol?
    
    var checkAppVersionData:CheckAppVersionData!
}

extension SplashPresenter: SplashPresenterProtocol {
    
    func loadData() {
        //FIXME
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.router?.go(to: .accountDetails)
//        })
       interactor?.checkAppVersion()
    }
    
    func navigateToSelectLanguage() {
        router?.go(to: .selectLanguage)
    }
    
    func checkMSISDN(){
        if let msisdn = UserDefaultHelper.msisdn,msisdn != ""{
            router?.go(to: .login)
        }
    }
    
    func checkStatus(){
        if checkAppVersionData.result == "soft"{
            router?.go(to: .softUpdate)
        }else if checkAppVersionData.result == "hard" {
            router?.go(to: .hardUpdate)
        }else{
            if !UserDefaultHelper.isLangSelected {
                view?.showLanguageSelection()
            }else{
                if let msisdn = UserDefaultHelper.msisdn,msisdn != ""{
                    GlobalData.shared.msisdn = msisdn
                    router?.go(to: .login)
                }else{
                    router?.go(to: .walkthrough)
                }
            }
        }
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    func onCheckAppVersionResponse(response: CheckAppVersionResponseModel?) {
        if let data = response?.data {
//            AppDelegate.sharedInstance().applicationTimeoutInMinutes = Int(data.appTimeOut ?? "8") ?? 8
            self.checkAppVersionData = data
            view?.onCheckAppVersionResponse(data: data)
        }
    }
    
    func onCheckAppVersionError(error: AppError) {
        Alert.showBottomSheetError(title: "somrthing_went_wrong".localized, message: "splash_error".localized, actionBtnTitle: "try_again".localized, delegate: self)
    }
    
    
}
extension SplashPresenter: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        interactor?.checkAppVersion()
    }
    
    func closeBtnTapped() {
        
    }
}
    
