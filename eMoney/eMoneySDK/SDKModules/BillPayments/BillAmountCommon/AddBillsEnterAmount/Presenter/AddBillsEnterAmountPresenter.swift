//
//  AddBillsEnterAmountPresenter.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation

class AddBillsEnterAmountPresenter {

    // MARK: Properties
    weak var view: AddBillsEnterAmountViewProtocol?
    var router: AddBillsEnterAmountRouterProtocol?
    var interactor: AddBillsEnterAmountInteractorProtocol?
    var inPutParameters: BillAccountDetailsParameters?
    
    var billDueAmount: String?
    var fine: VehicleTrafficFineDubaiPolice? = nil
}

extension AddBillsEnterAmountPresenter: AddBillsEnterAmountPresenterProtocol {
    func loadData() {
        self.view?.setupUI()
        view?.updateDefaultAmout(value: inPutParameters?.billDueAmount ?? "")
        if let dueAmount = inPutParameters?.billDueAmount,
           dueAmount.isEmpty == false {
            view?.updateNotes(text: "\(Strings.BillPayment.totalBillDue) \(dueAmount.addCurrency()), \(Strings.BillPayment.minimumDue) \(/inPutParameters?.billMin.addCurrency())")
        }else{
            view?.updateNotes(text: "\(Strings.BillPayment.minimumDue) \(/inPutParameters?.billMin)")
        }
        
    }
    
    
   
}

extension AddBillsEnterAmountPresenter: AddBillsEnterAmountInteractorOutputProtocol {
    
}

extension AddBillsEnterAmountPresenter{
    func navigateToBillCheckOutScreen() {
        guard let amount = inPutParameters?.billDueAmount?.filter("0123456789.".contains), let min = inPutParameters?.billMin, let max = inPutParameters?.billMax else { return }
        
        if /Double(amount) >= /Double(min) && /Double(amount) <= /Double(max){
            self.router?.go(to: .billCheckout(input: inPutParameters!))

        } else {
            
        }
    }
    
}
 
