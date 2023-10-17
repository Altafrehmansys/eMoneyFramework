//
//  SelectLanguagePresenter.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//  
//

import Foundation

class SelectLanguagePresenter {

    // MARK: Properties

    weak var view: SelectLanguageViewProtocol?
    var router: SelectLanguageRouterProtocol?
    var interactor: SelectLanguageInteractorProtocol?
    
    var languges:[LanguageData] = []
}

extension SelectLanguagePresenter: SelectLanguagePresenterProtocol {
    
    func loadData() {
        Loader.shared.showFullScreen()
        interactor?.getLanguages()
    }
    
    func selectLanguage(index: Int){
        for index in languges.indices {
            languges[index].isSelected = false
        }
        languges[index].isSelected = true
        self.view?.onLanguageResponse(languageData: languges)
    }
    
    func getLangPack(selectedLang:String) {
//        UserDefaultHelper.isLangSelected = true
//        LocaleManager.setAppleLanguageTo(selectedLang)
//        CommonMethods.setRootViewController(viewController: WalkthroughIntroRouter.setupModule())
//        return
        
        Loader.shared.showFullScreen()
        Task {
            let isSuccess = await LocaleManager.shared.getLanguagePackFromServer(langCode: selectedLang)
            DispatchQueue.main.async {
                Loader.shared.hideFullScreen()
                if isSuccess{
                    UserDefaultHelper.isLangSelected = true
                    LocaleManager.setAppleLanguageTo(selectedLang)
                    CommonMethods.setRootViewController(viewController: WalkthroughIntroRouter.setupModule())
                }else{
                    Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: Strings.Generic.generalErrorMsg)
                }
            }

        }
    }
    
    func navigateToWalkthrough() {
        router?.go(to: .walkThrough)
    }
    
}

extension SelectLanguagePresenter: SelectLanguageInteractorOutputProtocol {
    func onFetchLanguageResponse(response: [LanguageData]) {
        Loader.shared.hideFullScreen()
        for item in response {
            if item.languageCode?.lowercased() == "en" {
                item.isSelected = true
            }
        }
        for item in response {
            if item.languageCode?.lowercased() == LocaleManager.currentLanguage() {
                item.isSelected = true
            }else{
                item.isSelected = false
            }
        }
        languges = response
        self.view?.onLanguageResponse(languageData: languges)
    }
    func onFetchLanguageError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
}
