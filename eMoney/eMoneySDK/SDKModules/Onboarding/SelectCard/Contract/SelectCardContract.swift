//
//  SelectCardContract.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation

protocol SelectCardViewProtocol: ViperView {
    
}

protocol SelectCardPresenterProtocol: ViperPresenter {
    func setCardColor(model: SelectCardRequestModel,cardType : SelectCardColor)
}

protocol SelectCardInteractorProtocol: ViperInteractor {
    func callCardColorApiToServer(model:SelectCardRequestModel)
}

protocol SelectCardInteractorOutputProtocol: AnyObject {
    
    func selectCardRequestResponse(response: BaseResponseModel)
    func selectCardRequestResponseError(error: AppError)
}

protocol SelectCardRouterProtocol: ViperRouter {
    func go(to route: SelectCardRouter.Route)
}
