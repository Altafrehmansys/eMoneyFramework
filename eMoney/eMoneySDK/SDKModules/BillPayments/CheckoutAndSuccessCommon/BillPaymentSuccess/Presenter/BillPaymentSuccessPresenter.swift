//
//  BillPaymentSuccessPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation
import UIKit

class BillPaymentSuccessPresenter {

    // MARK: Properties

    weak var view: BillPaymentSuccessViewProtocol?
    var router: BillPaymentSuccessRouterProtocol?
    var interactor: BillPaymentSuccessInteractorProtocol?
    var datasource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var viewData: BillPaymentSuccessViewData?
    var hideAutoSave:Bool = false
    var input:BillAccountDetailsParameters? = nil
    var data:BillPaymentSuccessResponseData? = nil
    var isCollapsed:Bool = true  {
        didSet {
            DispatchQueue.main.async {
                self.setupDatasource()
                self.view?.reloadTableView()
            }
        }
    }
    fileprivate func setupDatasource() {
        self.datasource = []
        if isCollapsed {
            self.setupCollaspDatasource()
        }else{
            self.setupExpendedDatasource()
        }
        view?.reloadTableView()
    }
    private func setupCollaspDatasource() {
        var datasource:[StandardCellModel] = []
        datasource.append(SpaceTableViewCellModel(height:16))
        datasource.append(CollapsableTitleTableViewCellModel(actions:self.cellActions,title: Strings.BillPayment.transactionDetails, isCollapsed:isCollapsed))
        datasource.append(SpaceTableViewCellModel(height:8))
        datasource.append(GenericSingleLabelCellModel(content:"\(Strings.BillPayment.transactionId) \(/self.data?.transactionNumber)",
                          font:AppFont.appRegular(size: .body3),
                          color:AppColor.eAnd_Grey_100,
                          alignment:.left))
        datasource.append(SpaceTableViewCellModel(height:16))
        self.datasource = datasource
        self.view?.reloadTableView()
    }
    private func setupExpendedDatasource() {
        var datasource:[StandardCellModel] = []
        datasource.append(SpaceTableViewCellModel(height:16))
        datasource.append(CollapsableTitleTableViewCellModel(actions:self.cellActions,title: Strings.BillPayment.transactionDetails, isCollapsed:isCollapsed))
        datasource.append(SpaceTableViewCellModel(height:20))
        switch self.input?.billType {
        case .mobilEtisalat,.mobileDu,.ipMobile,.homeISTA,.homeLootahGas,.vehicleMawaqif,.vehicleSalik:
            datasource.append(KeyValueTableViewCellModel(key:"\(/self.input?.selectedItem?.title) \(Strings.BillPayment.number)",
                                                         value:/self.input?.accountNumber))
        case .homeDEWA:
            datasource.append(KeyValueTableViewCellModel(key:"\(/self.input?.selectedItem?.title) \(/self.data?.externalTransactionId)",
                                                         value:/self.input?.transactionId))
            datasource.append(SpaceTableViewCellModel(height:20))
            datasource.append(KeyValueTableViewCellModel(key:"\(Strings.BillPayment.easy_pay) \(Strings.BillPayment.number)",
                                                         value:/self.input?.accountNumber))
        case .vehicleTrafficFineDubaiPolice:
            datasource.append(KeyValueTableViewCellModel(key:"\(Strings.BillPayment.fineNumber) \(/self.data?.externalTransactionId)",
                                                         value:/self.input?.fine?.fineDetails?.serviceDetails?.first(where: { $0.isSelected == true})?.ticketFineAmount?.addCurrency()))
        default:
            datasource.append(KeyValueTableViewCellModel(key:"\(/self.input?.selectedItem?.title) \(Strings.BillPayment.number)",
                                                         value:/self.input?.accountNumber))
            
        }
        datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
                                              lineHeight: 1, leftSpace: 20, rightSpace: 20, topSpeace: 20, bottomSpace: 20))
        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.amount,
                                                     value:/self.data?.amountWithCurrency))
//        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.merchantFees,
//                                                     value:Strings.BillPayment.free))
        if self.input?.billType == .vehicleTrafficFineDubaiPolice {
            datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.fees,
                                                         value:self.input?.fine?.fineDetails?.serviceDetails?.first(where: { $0.isSelected == true})?.transactionFee?.addCurrency() ?? Strings.BillPayment.free))
        }else{
            datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.fees,
                                                         value:Strings.BillPayment.free))
        }
        
        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.totalPayment,
                                                     value:/self.data?.amountWithCurrency))
        datasource.append(SingleLineCellModel(lineColor: AppColor.eAnd_Grey_30,
                                              lineHeight: 1, leftSpace: 20, rightSpace: 20, topSpeace: 20, bottomSpace: 20))
        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.transactionId, value:/self.data?.transactionNumber))
        datasource.append(SpaceTableViewCellModel(height:20))
        datasource.append(KeyValueTableViewCellModel(key:Strings.BillPayment.date, value:/self.data?.formattedDate))
        datasource.append(SpaceTableViewCellModel(height:17))
        self.datasource = datasource
        self.view?.reloadTableView()
    }
    private func setupCellActions() {
        cellActions = StandardCellActions(cellSelected: { index, model in
            if let _ = model as? CollapsableTitleTableViewCellModel {
                self.isCollapsed.toggle()
                self.setupDatasource()
            }
        })
    }
    func completeRechargeTapped() {
        router?.go(to: .completeRecharge(input: input))
    }
}

extension BillPaymentSuccessPresenter: BillPaymentSuccessPresenterProtocol {

    
    
    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.setupDatasource()
        interactor?.getTransactionData(id: viewData?.transactionId ?? "")
        if let selectedItem = input?.selectedItem?.type, selectedItem ==  .ipMobile {
            view?.showCompleteRecharge()
        }
    }
}

extension BillPaymentSuccessPresenter: BillPaymentSuccessInteractorOutputProtocol {
    func didSuccessTransactionWith(data: BillPaymentSuccessResponseData) {
        view?.update(amount: data.amount ?? "", currency: data.currency ?? "")
        self.data = data
    }
    
    func didFailTransactionWith(error: AppError) {
        
    }
    
    
}
