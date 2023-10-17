//
//  AddBankBeneficiaryPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation

class AddBankBeneficiaryPresenter {

    // MARK: Properties

    weak var view: AddBankBeneficiaryViewProtocol?
    var router: AddBankBeneficiaryRouterProtocol?
    var interactor: AddBankBeneficiaryInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case addNewBeneficiary
            case beneficiaryDetails
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
  
}

extension AddBankBeneficiaryPresenter: AddBankBeneficiaryPresenterProtocol {
   
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension AddBankBeneficiaryPresenter: AddBankBeneficiaryInteractorOutputProtocol {
    
    func makeDataSource() {
        
        self.dataSource.removeAll()
        self.dataSource = self.collapsedDataSource()
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
            if let model = model as? AddNewBeneficiaryCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .addNewBeneficiary:
                    self.navigateToAddNewBeneficiary()
                case .beneficiaryDetails:
                    break
                case .general:
                    break
                }
            }
        }
    }
    
    private func collapsedDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        
        let addNewBeneficiaryCell = AddNewBeneficiaryCellModel(actions: self.cellActions,title: "New beneficiary", subTitle: "Add a recipient bank account",methodType:MethodType(type: .addNewBeneficiary))
        dataSource.append(addNewBeneficiaryCell)
        
        dataSource.append(spaceCell(with: 16))
        
        let titleCell1 = GenericSingleLabelCellModel(content: "Saved beneficiaries", font: AppFont.appSemiBold(size: .body2))
        dataSource.append(titleCell1)
        
        let savedBeneficiaryCell = BeneficiaryCellModel(actions: self.cellActions,beneficiaryName: "Abdullah Mohammed", bankImage: "", bankName: "Emirates NBD", bankIBANNumber: "AE 36 024 0085 1011 1618 4801",methodType: MethodType(type: .beneficiaryDetails))
        dataSource.append(savedBeneficiaryCell)
        
        
        let savedBeneficiaryCell1 = BeneficiaryCellModel(actions: self.cellActions,beneficiaryName: "Abdullah Mohammed", bankImage: "", bankName: "Emirates NBD", bankIBANNumber: "AE 36 024 0085 1011 1618 4801")
        dataSource.append(savedBeneficiaryCell1)
        
        let savedBeneficiaryCell2 = BeneficiaryCellModel(actions: self.cellActions,beneficiaryName: "Abdullah Mohammed", bankImage: "", bankName: "Emirates NBD", bankIBANNumber: "AE 36 024 0085 1011 1618 4801")
        dataSource.append(savedBeneficiaryCell2)
        return dataSource
    }
}
extension AddBankBeneficiaryPresenter {
    func navigateToAddNewBeneficiary() {
        self.router?.go(to: .addNewBeneficiary)
    }
    func navigateToAddedBeneficiaryDetails() {
        self.router?.go(to: .addedBeneficiaryDetails)
    }
}
