//
//  ManageSavedCardPresenter.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/05/2023.
//  
//

import Foundation

class ManageSavedCardPresenter {

    // MARK: Properties
    weak var view: ManageSavedCardViewProtocol?
    var router: ManageSavedCardRouterProtocol?
    var interactor: ManageSavedCardInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    
    
    private var cellActions: StandardCellActions?
}

extension ManageSavedCardPresenter: ManageSavedCardPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        
        self.setupActions()
        self.makeDataSource()
    }
}

// MARK: - Prepare Data Source
extension ManageSavedCardPresenter {
    func makeDataSource() {
        dataSource.removeAll()
        
        let cardCellModel = CardDetailsTableViewCellModel(holderName: "", cardNumber: "", expiryDate: "", cvv: "")
        dataSource.append(cardCellModel)
        
        self.view?.reloadData()
    }
}

// MARK: - Register Actions
extension ManageSavedCardPresenter {
    private func setupActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            
        })
    }
}

extension ManageSavedCardPresenter: ManageSavedCardInteractorOutputProtocol {
    
}
