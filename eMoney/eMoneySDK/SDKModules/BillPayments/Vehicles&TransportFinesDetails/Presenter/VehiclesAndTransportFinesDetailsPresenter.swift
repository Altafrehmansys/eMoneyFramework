//
//  VehiclesAndTransportFinesDetailsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation

class VehiclesAndTransportFinesDetailsPresenter {
    
    // MARK: Properties
    
    weak var view: VehiclesAndTransportFinesDetailsViewProtocol?
    var router: VehiclesAndTransportFinesDetailsRouterProtocol?
    var interactor: VehiclesAndTransportFinesDetailsInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var selectedItem: ListItems? = nil
    var fine: VehicleTrafficFineDubaiPolice = VehicleTrafficFineDubaiPolice()
    var fineDetails:FinePayBillsResponse? = nil
    var input:BillAccountDetailsParameters? = nil
}

extension VehiclesAndTransportFinesDetailsPresenter: VehiclesAndTransportFinesDetailsPresenterProtocol {

    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension VehiclesAndTransportFinesDetailsPresenter: VehiclesAndTransportFinesDetailsInteractorOutputProtocol {
    
    func openTraficFineBottomSheet(_ service:ServiceDetail?) {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 20))
        dataSource.append(SingleTitleAndButtonTableViewCellModel(title:Strings.BillPayment.fineDetails, buttonTitle: ""))
        
        var cells = [StandardCellModel]()
        service?.additionalInfo?.forEach({
            cells.append(spaceCell(with: 12))
            cells.append(TwoLabelsTableViewCellModel(leadingTitle:/$0.name,
                                                          trailingTitle: /$0.value))
            cells.append(dividerCell())
        })
        dataSource.removeLast()
        dataSource.append(TableViewCellModelWithUITableView(dataSource: cells,
                                                            borderWidth: 1,
                                                            borderColor: AppColor.eAnd_Grey_30,
                                                            cornerRadius: 12,
                                                            leftSpace: 24,
                                                            rightSpace: 24,
                                                            topSpace: 10,
                                                            bottomSpace: 20))
        
        let payFineButton = BaseButton()
        payFineButton.type = .GradientButton
        payFineButton.setTitle("\(Strings.BillPayment.continueToPayFine) \(/service?.amount?.addCurrency())", for: .normal)
        
        payFineButton.addTarget(self, action: #selector(payFineButtonTappedAction), for: .touchUpInside)
        
        self.router?.go(to: .fineDetail(dataSource: dataSource, actions: [payFineButton,BaseButton()]))
        
    }
    
    @objc private func payFineButtonTappedAction() {
        self.navigationToCheckout(self.input)
    }
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
            if let model = model as? VehiclesFinesDetailTableViewCellModel {
                for (i,service) in (self.fineDetails?.serviceDetails ?? []).enumerated() {
                    if service.fineNumber == model.serialNumber {
                        self.fineDetails?.serviceDetails?[i].isSelected = true
                        self.input?.billDueAmount = self.fineDetails?.serviceDetails?[i].amount?.addCurrency()
                        self.openTraficFineBottomSheet(self.fineDetails?.serviceDetails?[i])
                    }
                }
            }
        }
    }
    
    private func setDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(spaceCell(with: 12))
        dataSource.append(GenericSingleLabelCellModel(content:Strings.BillPayment.yourTrafficFines,
                                                      font: AppFont.appSemiBold(size: .body2),
                                                      color: AppColor.eAnd_Black_80))
        self.fineDetails?.serviceDetails?.forEach({
            dataSource.append(VehiclesFinesDetailTableViewCellModel(actions:self.cellActions,
                                                                    serialNumber: /$0.fineNumber,
                                                                    amount: "\(/$0.amount?.addCurrency())",
                                                                    dateAndTime: "\(Strings.BillPayment.date): \(/$0.date)",
                                                                    issuedBy: "\(Strings.BillPayment.issued_by): \(/$0.issuedBy)"))
        })
        
        return dataSource
    }
    
}

extension VehiclesAndTransportFinesDetailsPresenter{
    
    func navigateToAccountAmountDetail(){
        self.router?.go(to: .walletAmountDetail)
    }
    func navigationToCheckout(_ input:BillAccountDetailsParameters?) {
        self.input?.fine?.fineDetails = self.fineDetails
        self.router?.go(to: .checkout(input:self.input))
    }
}
