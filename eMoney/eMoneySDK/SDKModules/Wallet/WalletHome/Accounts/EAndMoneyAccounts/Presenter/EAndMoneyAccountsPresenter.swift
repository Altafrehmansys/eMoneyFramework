//
//  EAndMoneyAccountsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation

class EAndMoneyAccountsPresenter {

    // MARK: Properties

    weak var view: EAndMoneyAccountsViewProtocol?
    var router: EAndMoneyAccountsRouterProtocol?
    var interactor: EAndMoneyAccountsInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil

    
}

extension EAndMoneyAccountsPresenter: EAndMoneyAccountsPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
    func makeDataSource() {
        self.dataSource.removeAll()
        self.dataSource = self.setDataSource()
        view?.reloadData()
        
    }
    private func dividerCell() -> GenericDividerTableViewCellModel {
        let cellModel = GenericDividerTableViewCellModel()
        return cellModel
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
          
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(SingleLabelCellModel(title:Strings.Wallet.your_cards))
        dataSource.append(EAndMoneyAccountsCellModel(cardImage: "red_card", accountType: "e& money account", name: "Abdullah Mohammed", cardNumber: "1234 **** **** 3456", accountBalance: "Balance AED 740.00"))
        dataSource.append(spaceCell(with: 8))
        dataSource.append(AddNewCardCellModel(addNewCardTitle:Strings.Wallet.add_new_card))
        
      //  dataSource.append(EAndMoneyBankAccountCellModel(cardImage: "red_card", accountType: "e& money account", name: "Abdullah Mohammed", accountBalance: "Balance AED 740.00"))
        return dataSource
    }
}

extension EAndMoneyAccountsPresenter: EAndMoneyAccountsInteractorOutputProtocol {
    
}
