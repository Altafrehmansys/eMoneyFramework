//
//  EmployeeBeneficiaryDetailPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//  
//

import Foundation

class EmployeeBeneficiaryDetailPresenter {

    // MARK: Properties

    weak var view: EmployeeBeneficiaryDetailViewProtocol?
    var router: EmployeeBeneficiaryDetailRouterProtocol?
    var interactor: EmployeeBeneficiaryDetailInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
}

extension EmployeeBeneficiaryDetailPresenter: EmployeeBeneficiaryDetailPresenterProtocol {
    
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
}

extension EmployeeBeneficiaryDetailPresenter: EmployeeBeneficiaryDetailInteractorOutputProtocol {
   
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

        
        let manageCell = EmployeeBeneficiaryManageTableViewCellModel(message: "Next payment on Feb 25")
        dataSource.append(manageCell)
        
        dataSource.append(spaceCell(with: 20))
        
        let singleLine = SingleLineWithLabelTableViewCellModel(date: "17-05-2023")
        dataSource.append(singleLine)

        let cell1 = MobileBeneficiaryTableViewCellModel(message:"Money sent", time: "6:30 pm", amount: "6:30 pm", notes: "Yesterday’s lunch ty")
        dataSource.append(cell1)

        let cell2 = MobileBeneficiaryTableViewCellModel(message:"Money sent", time: "6:30 pm", amount: "6:30 pm")
        dataSource.append(cell2)

        let cell3 =  MobileBeneficiaryTableViewCellModel(message:"Money sent", time: "6:30 pm", amount: "6:30 pm", notes: "Yesterday’s lunch ty")
        dataSource.append(cell3)
        
        
        return dataSource
    }
    
}

