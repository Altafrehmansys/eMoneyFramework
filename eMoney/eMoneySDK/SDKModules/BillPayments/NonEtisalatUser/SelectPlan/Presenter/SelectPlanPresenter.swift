//
//  SelectPlanPresenter.swift
//  e&money
//
//  Created by Usama Zahid Khan on 25/05/2023.
//  
//

import Foundation
import UIKit
class SelectPlanPresenter {
    
    // MARK: Properties
    
    weak var view: SelectPlanViewProtocol?
    var router: SelectPlanRouterProtocol?
    var interactor: SelectPlanInteractorProtocol?
    var dataSource: [StandardCellModel] = []
    var tableViewCellActions: StandardCellActions? = nil
    var input:BillAccountDetailsParameters? = nil
    var selectedSegment = 0 {
        didSet {
            view?.reloadTableView()
            self.setDataSource()
        }
    }
    func setDataSource() {
        switch self.input?.billType {
        case .mobileDu:
            self.setMobileDUDatasource()
        case .vehicleSalik:
            self.setSalikDatasource()
        case .ipMobile:
            setInternationalMobileDatasource()
        default:break
        }
    }
    private func setMobileDUDatasource() {
        var dataSource:[StandardCellModel] = []
        if self.input?.title?.isEmpty == true {
            dataSource.append(AccountProfileCellModel(avatar: self.input?.selectedItem?.imageUrl ?? "",
                                                      name: /self.input?.subTitle,
                                                      number: nil))
        }else{
            dataSource.append(AccountProfileCellModel(avatar: self.input?.selectedItem?.imageUrl ?? "",
                                                      name: /self.input?.title,
                                                      number: /self.input?.subTitle))
        }
        dataSource.append(SpaceTableViewCellModel(height: 24))
//        dataSource.append(TopUpSegmentCellModel(actions:tableViewCellActions, title:"Select a recharge amount or bundle for this number"))
        if selectedSegment == 0 {
            dataSource.append(SpaceTableViewCellModel(height: 46))
            dataSource.append(TopUpAmountSliderCellModel(actions:self.tableViewCellActions,
                                                         amount: "\((self.input?.billMin ?? "0").addCurrency())",
                                                         sliderMinRange: Float(self.input?.billMin ?? "0") ?? 0.0,
                                                         sliderMaxRange: Float(self.input?.billMax ?? "0") ?? 0.0,
                                                         currentRange: Float(self.input?.billMin ?? "0") ?? 0.0))
            dataSource.append(SpaceTableViewCellModel(height: 32))
            dataSource.append(TopUpAmountCellModel(cellAction: tableViewCellActions,topUps: self.input?.denominations ?? []))
        }else{
            dataSource.append(GenericTitleAndButtonTableViewCellModel(actions: self.tableViewCellActions, title: "Most frequently used" , buttonTitle: "View all"))
            for i in 0...4 {
                dataSource.append(SpaceTableViewCellModel(height: 12))
                dataSource.append(PlanBundleCellModel(package: "500 MB Data / 25 Flexi Mins",
                                                      validity: "Validity: 30 days",
                                                      price: "AED 36.75"))
            }
        }
        self.dataSource = dataSource
        view?.reloadTableView()
    }
    private func setInternationalMobileDatasource() {
        var dataSource:[StandardCellModel] = []
        dataSource.append(AccountProfileCellModel(avatar: self.input?.selectedItem?.imageUrl ?? "",
                                                  name: self.input?.title ?? "-",
                                                  number: self.input?.subTitle ?? "-"))
        dataSource.append(SpaceTableViewCellModel(height: 24))
        dataSource.append(TopUpSegmentCellModel(actions:tableViewCellActions, title:"Select a recharge amount or bundle for this number"))
        if selectedSegment == 0 {
            dataSource.append(SpaceTableViewCellModel(height: 46))
            dataSource.append(TopUpAmountSliderCellModel(actions:self.tableViewCellActions,
                                                         amount: "AED \(self.input?.billMin ?? "0")",
                                                         sliderMinRange: Float(self.input?.billMin ?? "0") ?? 0.0,
                                                         sliderMaxRange: Float(self.input?.billMax ?? "0") ?? 0.0,
                                                         currentRange: Float(self.input?.billMin ?? "0") ?? 0.0))
            dataSource.append(SpaceTableViewCellModel(height: 32))
            dataSource.append(TopUpAmountCellModel(cellAction: tableViewCellActions,topUps: self.input?.denominations ?? []))
        }else{
            dataSource.append(GenericTitleAndButtonTableViewCellModel(actions: self.tableViewCellActions, title: "Most frequently used" , buttonTitle: "View all"))
            for i in 0...4 {
                dataSource.append(SpaceTableViewCellModel(height: 12))
                dataSource.append(PlanBundleCellModel(package: "500 MB Data / 25 Flexi Mins",
                                                      validity: "Validity: 30 days",
                                                      price: "AED 36.75"))
            }
        }
        self.dataSource = dataSource
        view?.reloadTableView()
    }
    private func setSalikDatasource() {
        var dataSource:[StandardCellModel] = []
        dataSource.append(AccountProfileCellModel(avatar: self.input?.selectedItem?.imageUrl ?? "",
                                                  name: self.input?.title ?? "-",
                                                  number: self.input?.subTitle ?? "-"))
        dataSource.append(SpaceTableViewCellModel(height: 24))
        dataSource.append(GenericSingleLabelCellModel(content: "Select an amount you want to top up".localized,
                                                      font: AppFont.appRegular(size: .body4),
                                                      color: AppColor.eAnd_Grey_100,
                                                      alignment: .center))
        dataSource.append(SpaceTableViewCellModel(height: 46))
        dataSource.append(TopUpAmountSliderCellModel(actions:self.tableViewCellActions,
                                                     amount: "AED \(self.input?.billMin ?? "0")",
                                                     sliderMinRange: Float(self.input?.billMin ?? "0") ?? 0.0,
                                                     sliderMaxRange: Float(self.input?.billMax ?? "0") ?? 0.0,
                                                     currentRange: Float(self.input?.billMin ?? "0") ?? 0.0))
        dataSource.append(SpaceTableViewCellModel(height: 32))
        dataSource.append(TopUpAmountCellModel(cellAction: tableViewCellActions,topUps: self.input?.denominations ?? []))
        self.dataSource = dataSource
        view?.reloadTableView()
    }
    private func setupTableViewCellActions() {
        tableViewCellActions = StandardCellActions{ index, model in
            if let _ = model as? TopUpAmountCellModel {
                let dueAmount = self.input?.denominations?[index]
                self.input?.billDueAmount = "AED \(dueAmount ?? 0)"
                if self.selectedSegment == 0 {
                    if let cellModel = self.dataSource.first(where: { $0 is TopUpAmountSliderCellModel }) as? TopUpAmountSliderCellModel {
                        cellModel.amount = "AED \(dueAmount ?? 0)"
                        cellModel.currentRange = Float(dueAmount ?? 0)
                    }
                }
                self.view?.reloadTableView()
            }
            if let _ = model as? TopUpSegmentCellModel {
                self.selectedSegment = index
            }
            if let _ = model as? GenericTitleAndButtonTableViewCellModel {
                self.selectedSegment = index
            }
            if let _ = model as? TopUpAmountSliderCellModel {
                self.input?.billDueAmount = "AED \(index)"
            }
        }
    }
}

extension SelectPlanPresenter: SelectPlanPresenterProtocol {
    func loadData() {
        view?.setupUI()
        self.setupTableViewCellActions()
        self.setDataSource()
    }
    func navigateToBillPaymentCheckout() {
        if let input = self.input {
            self.router?.go(to: .billPaymentCheckout(input))
        }
    }
}

extension SelectPlanPresenter: SelectPlanInteractorOutputProtocol {
    
}
