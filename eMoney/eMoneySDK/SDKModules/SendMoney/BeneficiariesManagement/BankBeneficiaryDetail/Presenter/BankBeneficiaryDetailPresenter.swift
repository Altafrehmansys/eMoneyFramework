//
//  BankBeneficiaryDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//  
//

import Foundation

class BankBeneficiaryDetailPresenter {

    // MARK: Properties

    weak var view: BankBeneficiaryDetailViewProtocol?
    var router: BankBeneficiaryDetailRouterProtocol?
    var interactor: BankBeneficiaryDetailInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
}

extension BankBeneficiaryDetailPresenter: BankBeneficiaryDetailPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
}

extension BankBeneficiaryDetailPresenter: BankBeneficiaryDetailInteractorOutputProtocol {
    
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
//            if let model = model as? AddNewBeneficiaryCellModel, let methodType = model.methodType as? MethodType {
//                switch methodType.type {
//                case .addNewBeneficiary:
//                    self.navigateToAddNewBeneficiary()
//                case .beneficiaryDetails:
//                    break
//                case .general:
//                    break
//                }
//            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        
        let singleLine = SingleLineWithLabelTableViewCellModel(date: "17-05-2023")
        dataSource.append(singleLine)
        
        let cell1 = MoneySendByBankTableViewCellModel(message: "Money sent", time: "6:30 pm", status: "Paid", amount:"AED 280.0")
        dataSource.append(cell1)
        
        let cell2 = MoneySendByBankTableViewCellModel(message: "Money sent", time: "6:30 pm", status: "Paid", amount:"AED 280.0")
        dataSource.append(cell2)
        
        
        let cell3 = MoneySendByBankTableViewCellModel(message: "Money sent", time: "6:30 pm", status: "Paid", amount:"AED 280.0")
        dataSource.append(cell3)
        
        
        return dataSource
    }
    
}
