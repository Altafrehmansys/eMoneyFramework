//
//  SendMoneySuccessPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation

class SendMoneySuccessPresenter {

    // MARK: Properties

    weak var view: SendMoneySuccessViewProtocol?
    var router: SendMoneySuccessRouterProtocol?
    var interactor: SendMoneySuccessInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions?
    var isCollapsed: Bool = true
}

extension SendMoneySuccessPresenter: SendMoneySuccessPresenterProtocol {
    
    func loadData() {
        view?.setUpUI()
        
        setupCellActions()
        self.makeDataSource()
    }
}

extension SendMoneySuccessPresenter: SendMoneySuccessInteractorOutputProtocol {
    func moveToHomeScreen() {
        self.router?.go(to: .moveToHome)
    }
}

// MARK: - Prepare Data source
extension SendMoneySuccessPresenter {
    func makeDataSource() {
        self.dataSource.removeAll()
        
        if isCollapsed {
            self.dataSource = self.collapsedDataSource()
        } else {
            self.dataSource = self.expandedDataSource()
        }
        view?.reloadData()
    }
    
    private func collapsedDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: "Transfer details", isCollapsed: self.isCollapsed)
        dataSource.append(titleCellModel)
        
        let singleLabelCell = GenericSingleLabelCellModel(content: "Transaction ID 34560981",
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 20)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func expandedDataSource() -> [StandardCellModel] {
        var dataSource = [StandardCellModel]()
        let titleCellModel = CollapsableTitleTableViewCellModel(actions: self.cellActions, title: "Transfer details", isCollapsed: self.isCollapsed)
        dataSource.append(titleCellModel)
        
        let singleLabelCell = GenericSingleLabelCellModel(content: "Transaction ID 34560981",
                                                          font: AppFont.appRegular(size: .body3),
                                                          topSpace: 4,
                                                          leftSpace: 20)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        dataSource.append(singleLabelCell)
        return dataSource
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.makeDataSource()
            }
        })
    }
}
