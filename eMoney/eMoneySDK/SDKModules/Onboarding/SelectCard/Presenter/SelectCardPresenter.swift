//
//  SelectCardPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation

class SelectCardPresenter {

    // MARK: Properties

    weak var view: SelectCardViewProtocol?
    var router: SelectCardRouterProtocol?
    var interactor: SelectCardInteractorProtocol?
    var cardColorEnum: SelectCardColor?
}

extension SelectCardPresenter: SelectCardPresenterProtocol {
    
    func setCardColor(model: SelectCardRequestModel,cardType : SelectCardColor) {
        cardColorEnum = cardType
        Loader.shared.showFullScreen()
        interactor?.callCardColorApiToServer(model: model)
    }
   
}

extension SelectCardPresenter: SelectCardInteractorOutputProtocol {
    func selectCardRequestResponse(response: BaseResponseModel) {
        Loader.shared.hideFullScreen()
        router?.go(to: .navigateToWallet(cardType: cardColorEnum ?? .Red))
    }
    
    func selectCardRequestResponseError(error: AppError) {
        Loader.shared.hideFullScreen()
        Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
    }
    
    
}
