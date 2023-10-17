//
//  FineDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

class FineDetailPresenter {

    // MARK: Properties

    weak var view: FineDetailViewProtocol?
    var router: FineDetailRouterProtocol?
    var interactor: FineDetailInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var isCollapsed: Bool = true
    
}

extension FineDetailPresenter: FineDetailPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension FineDetailPresenter: FineDetailInteractorOutputProtocol {
    
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
        let expandCollapsCell = CollapsableTitleTableViewCellModel(actions:self.cellActions,title:Strings.BillPayment.paymentDetails, isCollapsed:true)
        dataSource.append(expandCollapsCell)
        dataSource.append(spaceCell(with: 20))
        
        let keyValueCell = KeyValueTableViewCellModel(key:Strings.BillPayment.totalPayment, value: "AED 220.50")
        dataSource.append(keyValueCell)
        dataSource.append(spaceCell(with: 20))
        let promoCell = PromoCodeCellModel(promoLabel:Strings.BillPayment.haveAPromoCode)
        dataSource.append(promoCell)
        dataSource.append(spaceCell(with: 20))
        return dataSource
        
    }
    private func expandedDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        let expandCollapsCell = CollapsableTitleTableViewCellModel(actions:self.cellActions,title: Strings.BillPayment.paymentDetails, isCollapsed:false)
        dataSource.append(expandCollapsCell)
        dataSource.append(spaceCell(with: 20))
        
        let keyValueCell = KeyValueTableViewCellModel(key: Strings.BillPayment.totalPayment, value: "AED 220.50")
        dataSource.append(keyValueCell)
        dataSource.append(spaceCell(with: 20))
        let promoCell = PromoCodeCellModel(promoLabel:Strings.BillPayment.haveAPromoCode)
        dataSource.append(promoCell)
        dataSource.append(spaceCell(with: 20))
        
        
        dataSource.append(spaceCell(with: 20))
        let expandCollapsCell1 = CollapsableTitleTableViewCellModel(title:Strings.BillPayment.paymentDetails, isCollapsed:false)
        dataSource.append(expandCollapsCell1)
        dataSource.append(spaceCell(with: 20))
        
        let keyValueCell1 = KeyValueTableViewCellModel(key: Strings.BillPayment.totalPayment, value: "AED 220.50")
        dataSource.append(keyValueCell1)
        dataSource.append(spaceCell(with: 20))
        let promoCell1 = PromoCodeCellModel(promoLabel:Strings.BillPayment.haveAPromoCode)
        dataSource.append(promoCell1)
        dataSource.append(spaceCell(with: 20))
        return dataSource
        
    }
    

}

extension FineDetailPresenter {
    func navigateToSuccessfulScreen() {
        self.router?.go(to: .successFullScreen)
    }
}
