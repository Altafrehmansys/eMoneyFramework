//
//  AddNewCardPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 05/05/2023.
//  
//

import Foundation

class AddNewCardPresenter {
    
    // MARK: Properties
    weak var view: AddNewCardViewProtocol?
    var router: AddNewCardRouterProtocol?
    var interactor: AddNewCardInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    
    var cardHolderName: String = ""
    var cardNumber: String = ""
    var expiryDate: String = ""
}

// MARK: - Class MEthods
extension AddNewCardPresenter: AddNewCardPresenterProtocol {
    func loadData() {
        view?.setupUI()
        
        self.makeDataSource()
    }
    
    func updateData(with cardDetials: CardDetails) {
        cardHolderName = cardDetials.name ?? ""
        cardNumber = cardDetials.number ?? ""
        expiryDate = cardDetials.expiryDate ?? ""
        
        self.makeDataSource()
    }
}

// MARK: - Prepare Data source
extension AddNewCardPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        
        let cellModel = CardDetailsTableViewCellModel(holderName: cardHolderName, cardNumber: cardNumber, expiryDate: expiryDate, cvv: "")
        self.dataSource.append(cellModel)
        
        view?.reloadData()
    }
}

// MARK: - Navigations
extension AddNewCardPresenter {
    func navigateToScanCard() {
        router?.go(to: .scanCard)
    }
}

// MARK: - Add New Card Interactor Output Protocol
extension AddNewCardPresenter: AddNewCardInteractorOutputProtocol {
    
}
