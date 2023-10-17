//
//  AlternateFlowForLeanContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 22/06/2023.
//  
//

import Foundation

protocol AlternateFlowForLeanViewProtocol: ViperView {
    var presenter: AlternateFlowForLeanPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol AlternateFlowForLeanPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    
    func loadData()
    func makeDataSource()
    func dismissView()
}

protocol AlternateFlowForLeanInteractorProtocol: ViperInteractor {
    func getOptionsList()
    func initializeAddCard()
}

protocol AlternateFlowForLeanInteractorOutputProtocol: AnyObject {
    func onOptionsList(Response response: AddMoneyOptionsListResponseModel?)
    func onOptionsList(Error error: AppError)
    
    func onAddCard(Response response: AddDebitCardResponseModel)
    func onAddCard(Error error: AppError)
}

protocol AlternateFlowForLeanRouterProtocol: ViperRouter {
    func go(to route: AlternateFlowForLeanRouter.Route)
}
