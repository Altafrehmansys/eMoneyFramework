//
//  SendMoneyPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 08/05/2023.
//  
//

import Foundation
import UIKit
class SendMoneyPresenter {
    
    // MARK: Properties
    
    weak var view: SendMoneyViewProtocol?
    var router: SendMoneyRouterProtocol?
    var interactor: SendMoneyInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    
    class MethodType: MethodOptionsBaseTypes {
        enum CellType {
            case bankAccount
            case mobileAccount
            case employeeAccount
            case scanAccount
            case abroadAccount
            case general
        }
       var type: CellType = .general
        
        init(type: CellType) {
            self.type = type
            }
       }
}

extension SendMoneyPresenter: SendMoneyPresenterProtocol {
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension SendMoneyPresenter: SendMoneyInteractorOutputProtocol {
    func makeDataSource() {
        self.dataSource.removeAll()
        
        addPaymentRequestsData()
        addRecentTransferData()
       
        let buttonCell = SingleButtonTableViewCellModel(actions: self.cellActions, title: "View & manage all beneficiaries".localized, type: .PlainButton, font: AppFont.appMedium(size: .body4))
        self.dataSource.append(buttonCell)
        
        self.dataSource.append(spaceCell(with: 20))
        
        let titleCell = GenericSingleLabelCellModel(content: "Local transfer", font: AppFont.appSemiBold(size: .body2))
        self.dataSource.append(titleCell)
        
        let methodCell1 = MethodOptionTableViewCellModel(actions: self.cellActions, image: "bank-account", name: "To bank account",methodType: MethodType(type: .bankAccount))
        
        self.dataSource.append(methodCell1)
        
        self.dataSource.append(self.dividerCell())
        
        let methodCell2 = MethodOptionTableViewCellModel(actions: self.cellActions,image: "mobile-account", name: "To mobile number",methodType: MethodType(type: .mobileAccount))
        self.dataSource.append(methodCell2)
        self.dataSource.append(self.dividerCell())
        
        let methodCell3 = MethodOptionTableViewCellModel(actions: self.cellActions,image: "employee-account", name: "Employee direct pay",methodType: MethodType(type: .employeeAccount))
        self.dataSource.append(methodCell3)
        self.dataSource.append(self.dividerCell())
        
        let methodCell4 = MethodOptionTableViewCellModel(actions: self.cellActions,image: "scan-account", name: "Scan QR to send",methodType: MethodType(type: .scanAccount))
        self.dataSource.append(methodCell4)
        
        self.dataSource.append(spaceCell(with: 20))
        
        let titleCell1 = GenericSingleLabelCellModel(content: "International transfers", font: AppFont.appSemiBold(size: .body2))
        self.dataSource.append(titleCell1)
        self.dataSource.append(spaceCell(with: 20))
        let methodCell5 = MethodOptionTableViewCellModel(actions: self.cellActions,image: "abroad-account", name: "Send abroad",methodType:MethodType(type:.abroadAccount))
        self.dataSource.append(methodCell5)
        
        view?.reloadData()
    }
    
    private func addPaymentRequestsData(){
         
        let paymentRequests = [ SendMoneyPaymentRequestCollectionViewCellModel(actions:self.cellActions,name: "Abdullah Mansoor", amount: "AED 20.00", image: "bank-account"),
            SendMoneyPaymentRequestCollectionViewCellModel(actions:self.cellActions,name: "Abdullah Yousaf", amount: "AED 100.00", image: "bank-account")]
        
        let browseCellModel = BrowseServicesTableViewCellModel(actions:self.cellActions,title: "Payment requests (2)",
            dataSource: paymentRequests,
            itemSize: CGSize(width:UIScreen.main.bounds.width*0.7, height: 70),
            interItemSpacing: 0)
        dataSource.append(browseCellModel)
        
    }
    private func addRecentTransferData(){
         
        let recentTransfers = [SendMoneyRecentTransferCollectionViewCellModel(actions: self.cellActions, name: "Khan Mohammed Rehman", amount: "****2815", account: "AED 280.0", image: "bank-account"),
            SendMoneyRecentTransferCollectionViewCellModel(actions: self.cellActions, name: "Khan Mohammed Rehman", amount: "****2815", account: "AED 280.0", image: "bank-account")]
        
        let browseCellModel = BrowseServicesTableViewCellModel(actions:self.cellActions,title: "Recent transfers",
            dataSource: recentTransfers,
                                                               itemSize: CGSize(width:UIScreen.main.bounds.width*0.7, height: 92),
            interItemSpacing: 0)
        dataSource.append(browseCellModel)
        
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
            if let model = model as? MethodOptionTableViewCellModel, let methodType = model.methodType as? MethodType {
                switch methodType.type {
                case .bankAccount:
                    self.navigateToSendMoneyToBankAccount()
                case .mobileAccount:
                    print("")
                case .employeeAccount:
                    print("")
                case .scanAccount:
                    self.navigateToQRCodeScan()
                case .abroadAccount:
                    self.navigateToSendMoneyToAbroad()
                case .general:
                    break
                }
            }
            if let model = model as? SingleButtonTableViewCellModel{
                self.loadAllBeneficiaries()
            }
            if let model = model as? SendMoneyPaymentRequestCollectionViewCellModel{
                print(model)
            }
            if let model = model as? SendMoneyRecentTransferCollectionViewCellModel{
                print(model)
            }
        })
    }
}

// MARK: - Make Navigations
extension SendMoneyPresenter {
    func navigateToSendMoneyToBankAccount() {
        self.router?.go(to: .sendMoneyToBankAccount)
    }
    func navigateToSendMoneyToAbroad() {
        self.router?.go(to: .sendMoneyToAbroad)
    }
    
    func navigateToQRCodeScan() {
        self.router?.go(to: .sendMoneyByQRCode)
    }
    func loadAllBeneficiaries() {
        self.router?.go(to: .loadAllBeneficiars)
    }
}

