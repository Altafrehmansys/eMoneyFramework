//
//  AddMobileBillPaymentDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 23/05/2023.
//  
//

import Foundation

class AddMobileBillPaymentDetailPresenter {

    // MARK: Properties

    weak var view: AddMobileBillPaymentDetailViewProtocol?
    var router: AddMobileBillPaymentDetailRouterProtocol?
    var interactor: AddMobileBillPaymentDetailInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var isCollapsed: Bool = true
}

extension AddMobileBillPaymentDetailPresenter: AddMobileBillPaymentDetailPresenterProtocol {
    func navigateToSuccessScreen() {
        self.router?.go(to: .successScreen)
    }
    
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension AddMobileBillPaymentDetailPresenter: AddMobileBillPaymentDetailInteractorOutputProtocol {
    
    func makeDataSource() {
        
        self.dataSource.removeAll()
        
        if isCollapsed {
            self.dataSource = self.collapsedDataSource()
        } else {
            self.dataSource = self.expandedDataSource()
        }
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
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.makeDataSource()
            }
        })
    }
    
    private func collapsedDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        let expandCollapsCell = CollapsableTitleTableViewCellModel(actions:self.cellActions,title: "Payment details", isCollapsed:true)
        dataSource.append(expandCollapsCell)
        dataSource.append(spaceCell(with: 20))
        
        let keyValueCell = KeyValueTableViewCellModel(key: "Your total payment", value: "AED 220.50")
        dataSource.append(keyValueCell)
        dataSource.append(spaceCell(with: 20))
        return dataSource
        
    }
    private func expandedDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        let expandCollapsCell = CollapsableTitleTableViewCellModel(actions:self.cellActions,title: "Payment details", isCollapsed:false)
        dataSource.append(expandCollapsCell)
        dataSource.append(spaceCell(with: 20))
        
        let keyValueCell = KeyValueTableViewCellModel(key: "Your total payment", value: "AED 220.50")
        dataSource.append(keyValueCell)
        
   
        let expandCollapsCell1 = KeyValueTableViewCellModel(key: "Your total payment", value: "AED 220.50")
        dataSource.append(expandCollapsCell1)
     
        
        let keyValueCell1 = KeyValueTableViewCellModel(key: "Your total payment", value: "AED 220.50")
        dataSource.append(keyValueCell1)
      
        return dataSource
        
    }
}
