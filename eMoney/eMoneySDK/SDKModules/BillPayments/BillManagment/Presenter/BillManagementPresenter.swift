//
//  BillManagementPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit

class BillManagementPresenter {

    // MARK: Properties

    weak var view: BillManagementViewProtocol?
    var router: BillManagementRouterProtocol?
    var interactor: BillManagementInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
}

extension BillManagementPresenter: BillManagementPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
    
}

extension BillManagementPresenter: BillManagementInteractorOutputProtocol {
    
   
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
        
        let singleLine = BillManageTableViewCellModel(title: "Auto payment", subTitle: "Visa card 8877 **** ****")
        dataSource.append(singleLine)
        
        dataSource.append(spaceCell(with: 20))
        
        let cell1 = SingleLineWithLabelTableViewCellModel(date: "June 29, 2023")
        dataSource.append(cell1)
        dataSource.append(spaceCell(with: 20))
        
        let cell2 = ManageDueBillTableViewCellModel(title: "Paid to DEVA", subTitle: "at 6:30 PM", status: "paid", amount: "210 AED")
        dataSource.append(cell2)
        
        let cell3 = SingleLineWithLabelTableViewCellModel(date: "June 29, 2023")
        dataSource.append(cell3)
        
        let cell4 = ManageDueBillTableViewCellModel(title: "Paid to DEVA", subTitle: "at 6:30 PM", status: "paid", amount: "210 AED")
        dataSource.append(cell4)
        
       return dataSource
    }
    
}

extension BillManagementPresenter{
    func editAccountDetails() {
        var dataSource = [StandardCellModel]()
        
        let titleCell = GenericSingleLabelCellModel(content: "Edit account details", font:AppFont.appRegular(size:.body2), alignment: .center)
        dataSource.append(titleCell)
        
        let titleCell2 = ImageWithBelowTitleTableViewCellModel(title: "DEWA - Office", imgName: "etihad")
        dataSource.append(titleCell2)
        
        dataSource.append(spaceCell(with: 20))
        
        dataSource.append(StandardTextFieldTableViewCellModel(placeHolderText: "Enter EasyPay number",trailingImage: "info-circle-bank"))
        
        dataSource.append(StandardTextFieldTableViewCellModel(placeHolderText: "Name/Nickname (optional)"))
        
        dataSource.append(spaceCell(with: 40))
        
        let updateAccountDetails = BaseButton()
        updateAccountDetails.type = .GradientButton
        updateAccountDetails.setTitle("Update account details", for: .normal)
       // addDevice.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        self.router?.go(to: .editAccount(dataSource: dataSource,actions: [updateAccountDetails,BaseButton()]))
    }
    
    func deleteBiller() {
        
        let dataSource = DeleteAccountDetailsViewData(deleteIconName: "trash_icon", deleteTitle: "Are you sure you want to delete?", deleteSubTitle: "All data related to DEWA - Office account will be deleted", deleteBtn: "Delete", cancelBtn: "Cancel")
        self.router?.go(to: .deleteBiller(dataSource: dataSource, delegate: self))
    }
    func downloadStatement() {
        var dataSource = [StandardCellModel]()
        
        let titleCell = GenericSingleLabelCellModel(content: "Edit account details", font:AppFont.appRegular(size:.body2), alignment: .center)
        dataSource.append(titleCell)
        
        let titleCell2 = ImageWithBelowTitleTableViewCellModel(title: "DEWA - Office", imgName: "etihad")
        dataSource.append(titleCell2)
        
        dataSource.append(spaceCell(with: 20))
        
        
        dataSource.append(DownloadStatementTableViewCellModel(startDatePlaceHolderText: "Start date", endDatePlaceHolderText: "End date",startDatetrailingImage: "calendar-icon",endDatetrailingImage: "calendar-icon"))
       
        dataSource.append(spaceCell(with: 40))
        
        let download = BaseButton()
        download.type = .GradientButton
        download.setTitle("Download", for: .normal)
       // addDevice.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        self.router?.go(to: .downloadStatement(dataSource: dataSource,actions: [download,BaseButton()]))
    }
}

extension BillManagementPresenter : DeleteAccountDetailsViewDelegate{
    func didTapCloseButton() {
        UIApplication.getTopViewController()?.dismiss(animated: true)
    }
    func didTapCancelButton() {
        UIApplication.getTopViewController()?.dismiss(animated: true)
    }
    func didTapDeleteButton() {
        
    }
}
