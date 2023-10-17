//
//  SendAbroadPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation

class SendAbroadPresenter {

    // MARK: Properties

    weak var view: SendAbroadViewProtocol?
    var router: SendAbroadRouterProtocol?
    var interactor: SendAbroadInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource()
    }
}

extension SendAbroadPresenter: SendAbroadPresenterProtocol {
    func routeToExchangeAlert() {
        
    }
    func startTransfer() {
        
    }
}
// MARK: - Prepare Datasource
extension SendAbroadPresenter {
    
    func makeDataSource() {
        
        let transferModel =  SendAbroadPickupTableViewCellModel(title:"To India", cellState: .selectCountry)
        dataSource.append(transferModel)
        let exchangeModel =  SendAbroadExchangeRateTableViewCellModel(title:"Set an exchange rate alert", desc:"We’ll notify you when the rate reaches your preference or higher.")
        dataSource.append(exchangeModel)
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? TransferStatussTableViewCellModel {
               
            }
            
            if let cellModel = model as? TransferExpandedTableViewCellModel {
              
            }
            
            
        }
    }
    
    
}

extension SendAbroadPresenter: SendAbroadInteractorOutputProtocol {
    
}
