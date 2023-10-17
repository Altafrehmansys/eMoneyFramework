//
//  DueBillsPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//  
//

import Foundation

class DueBillsPresenter {

    // MARK: Properties

    weak var view: DueBillsViewProtocol?
    var router: DueBillsRouterProtocol?
    var interactor: DueBillsInteractorProtocol?
    
    var dataSource: [StandardCellModel] = []
    var cellActions: StandardCellActions? = nil
    var isAllSelected:Bool = false
    var selectedBills:Int = 0
}

extension DueBillsPresenter: DueBillsPresenterProtocol {

    func loadData() {
        view?.setupUI()
        self.setupCellActions()
        self.makeDataSource()
    }
}

extension DueBillsPresenter: DueBillsInteractorOutputProtocol {
    
    func makeDataSource() {
        
        self.dataSource.removeAll()
         
        self.dataSource = tblViewDataSource()
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
            if let _ = model as? SingleTitleAndButtonTableViewCellModel {
                self.isAllSelected = !self.isAllSelected
                for bill in self.dataSource {
                    if let bill = bill as? DueBillsTableViewCellModel {
                        bill.isSelected = self.isAllSelected
                    }
                }
                self.updateBillCount()
            }
            
            if let model = model as? DueBillsTableViewCellModel {
                model.isSelected = model.isSelected == true ? false : true
            }
            self.view?.reloadData()
            self.updateBillCount()
        })
    }
    
    private func tblViewDataSource() -> [StandardCellModel] {
        
        var dataSource = [StandardCellModel]()
        dataSource.append(SpaceTableViewCellModel(height: 8))
        let cell1 = GenericSingleLabelCellModel(content:Strings.BillPayment.select_one_or_more_biller_to_pay,
                                                font: AppFont.appRegular(size: .body3))
        dataSource.append(cell1)
        dataSource.append(SpaceTableViewCellModel(height: 8))
        let cell2 = SingleTitleAndButtonTableViewCellModel(actions:self.cellActions,
                                                           title:Strings.BillPayment.due_soon,
                                                           buttonTitle: self.isAllSelected ? Strings.Generic.cancel :Strings.BillPayment.select_all)
         dataSource.append(cell2)
        
        let cell3 = DueBillsTableViewCellModel(actions:self.cellActions,title: "Home electricity", subTitle: "Etihad water &... • AED 280.00", tagOneTitle: "Overdue Feb 02", tagOneIcon: "tick-icon", isTagTwoEnable: false,isSelected:false)
         dataSource.append(cell3)
        
        dataSource.append(dividerCell())
        
        let cell4 = DueBillsTableViewCellModel(actions:self.cellActions,title: "Home electricity", subTitle: "Etihad water &... • AED 280.00", tagOneTitle: "Overdue Feb 02", tagOneIcon: "tick-icon", isTagTwoEnable: true,tagTwoTitle: "Overdue Feb 02",tagTwoBgColor:AppColor.eAnd_Warning_100,isSelected: false)
         dataSource.append(cell4)
        
        dataSource.append(dividerCell())
        
        let cell5 = DueBillsTableViewCellModel(actions:self.cellActions,title: "Home electricity", subTitle: "Etihad water &... • AED 280.00", tagOneTitle: "Overdue Feb 02", tagOneIcon: "tick-icon", isTagTwoEnable: true,tagTwoTitle: "Overdue Feb 02",tagTwoBgColor:AppColor.eAnd_Warning_100,isSelected: false)
         dataSource.append(cell5)
    
        return dataSource
        
    }
    private func updateBillCount() {
        let billsSelected = self.dataSource.filter {
            if let model = $0 as? DueBillsTableViewCellModel,
               model.isSelected == true {
                return true
            }
            return false
        }
        self.selectedBills = billsSelected.count
        self.view?.setBillsCount(billsSelected.count)
    }
}

extension DueBillsPresenter {
    func moveToDueBillsDetailsScreen() {
        if self.selectedBills > 0 {
            self.router?.go(to: .navigateToDueBillsDetail)
        }else{
            Alert.showBottomSheetError(title:Strings.BillPayment.alert, message:Strings.BillPayment.select_one_or_more_biller_to_pay)
        }
    }
}
