//
//  SuccessfulTransferPresenter.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation

class SuccessfulTransferPresenter {
    
    // MARK: Properties
    
    weak var view: SuccessfulTransferViewProtocol?
    var router: SuccessfulTransferRouterProtocol?
    var interactor: SuccessfulTransferInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellAction: StandardCellActions?
    
    func viewDidLoad() {
        view?.setupUI()
        setupCellActions()
        makeDataSource(isExpanded: false)
    }
}

extension SuccessfulTransferPresenter: SuccessfulTransferPresenterProtocol {
    func routeToHomepage() {
      print("routeToHomepage")
        router?.go(to: .homePage)
    }
    func shareTapped() {
       print("shareTapped")
    }
    func routeToTransferStatus() {
        router?.go(to: .transferStatus)
    }
}
// MARK: - Prepare Datasource
extension SuccessfulTransferPresenter {
    
    func makeDataSource(isExpanded: Bool) {
        
        let headingModel =  SuccessfulHeadingTableViewCellModel(image: "successfulTransfer", heading: "Successful International transfer ")
        dataSource.append(headingModel)
        
        let cellModel =  EarnTransferTableViewCellModel(image: "diamond", descriptions: "You have earned 100 e& points for this transfer", color: AppColor.eAnd_Main_USP)
        dataSource.append(cellModel)
        let cellModel1 =  EarnTransferTableViewCellModel(image: "money-tick", descriptions: "You have earned AED 2.00 in cashback ", color: AppColor.eAnd_Online_Exclusive)
        dataSource.append(cellModel1)
        
        if !isExpanded {
            let cellModel2 = TransferStatussTableViewCellModel(actions: cellAction, transactionId: "Transaction ID 34560981098716242", isExpanded: isExpanded)
            dataSource.append(cellModel2)
        }
        else {
            
            let cellModelExpand = TransferExpandedTableViewCellModel(actions: cellAction,fullname: "Hassan Shafi", method: "Bank account", iban: "INR 111,212.31", recieveAmount: "INR 111,212.31", sentAmount: "AED 5,000.00", fees: " AED 10.00  AED 00.00", totalPayment: "AED 5,000.00", transactionId: "34560981098716242", date: "Dec 23, 2023 at 09:41 am", isExpanded: isExpanded)
            dataSource.append(cellModelExpand)
        }
        
        let cellModel3 = TransferProgressTableViewCellModel(actions: cellAction,status: "In progress", desc: "A tracking link has been sent to recipient via SMS & WhatsApp.")
        dataSource.append(cellModel3)
        view?.reloadData()
    }
    
    private func setupCellActions() {
        cellAction = StandardCellActions {[weak self] index, model in
            if let cellModel = model as? TransferStatussTableViewCellModel {
                cellModel.isExpanded = !cellModel.isExpanded
                self?.dataSource.removeAll()
                self?.makeDataSource(isExpanded: cellModel.isExpanded)
            }
            
            if let cellModel = model as? TransferExpandedTableViewCellModel {
                cellModel.isExpanded = !cellModel.isExpanded
                self?.dataSource.removeAll()
                self?.makeDataSource(isExpanded: cellModel.isExpanded)
            }
            if let cellModel = model as? TransferProgressTableViewCellModel {
                self?.routeToTransferStatus()
            }
            
            
        }
    }
    
    
}

extension SuccessfulTransferPresenter: SuccessfulTransferInteractorOutputProtocol {
    
}
