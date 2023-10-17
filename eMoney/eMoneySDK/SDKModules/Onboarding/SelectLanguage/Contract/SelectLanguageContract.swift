//
//  SelectLanguageContract.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 13/04/2023.
//  
//

import Foundation

protocol SelectLanguageViewProtocol: ViperView {
    func onLanguageResponse(languageData: [LanguageData])
}

protocol SelectLanguagePresenterProtocol: ViperPresenter {
    func loadData()
    func selectLanguage(index: Int)
    func navigateToWalkthrough()
    func getLangPack(selectedLang:String)
}

protocol SelectLanguageInteractorProtocol: ViperInteractor {
    func getLanguages()
}

protocol SelectLanguageInteractorOutputProtocol: AnyObject {
    func onFetchLanguageResponse(response : [LanguageData])
    func onFetchLanguageError(error : AppError)
}

protocol SelectLanguageRouterProtocol: ViperRouter {
    func go(to route: SelectLanguageRouter.Route)
}
