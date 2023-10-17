//
//  AddNewCardContract.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 05/05/2023.
//  
//

import Foundation

protocol AddNewCardViewProtocol: ViperView {
    var presenter: AddNewCardPresenterProtocol! { get set }
    
    func setupUI()
    func reloadData()
}

protocol AddNewCardPresenterProtocol: ViperPresenter {
    var dataSource: [StandardCellModel] { get }
    var cardHolderName: String { get }
    var cardNumber: String { get }
    var expiryDate: String { get }
    
    // Class Methods
    func loadData()
    func makeDataSource()
    func updateData(with cardDetials: CardDetails)
    
    // Navigations
    func navigateToScanCard()
}

protocol AddNewCardInteractorProtocol: ViperInteractor {
    
}

protocol AddNewCardInteractorOutputProtocol: AnyObject {
}

protocol AddNewCardRouterProtocol: ViperRouter {
    func go(to route: AddNewCardRouter.Route)
}
