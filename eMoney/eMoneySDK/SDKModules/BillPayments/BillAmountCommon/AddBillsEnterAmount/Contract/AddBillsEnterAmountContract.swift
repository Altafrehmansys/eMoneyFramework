//
//  AddBillsEnterAmountContract.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation

struct BillAccountDetailsParameters {
    
    var subTitle:String?
    var title:String?
    var isSavedBill:Bool
    var billType:BillsAnsTopUpType
    var selectedItem:ListItems?
    var billDueAmount:String?
    var enterBillAmount:String?
    var fine:VehicleTrafficFineDubaiPolice?

    var billMin: String
    var billMax: String
    var transactionId: String?
    var accountNumber: String?
    var denominations:[Int]?
    var pin: String?
    var isPrepaid:Bool?
    
    init(billTitle:String? = nil,
         billSubTitle:String? = nil,
         isSavedBill:Bool = false,
         billType:BillsAnsTopUpType,
         selectedItem:ListItems? = nil,
         billDueAmount:String? = nil,
         enterBillAmount:String? = nil,
         traficFineDubaiPolice:VehicleTrafficFineDubaiPolice? = nil,
         billMin: String,
         billMax: String,
         transactionId: String?,
         accountNumber: String?,
         denominations:[Int]? = [],
         pin: String? = "") {
        self.subTitle = billTitle
        self.title = billSubTitle
        self.isSavedBill = isSavedBill
        self.billType = billType
        self.selectedItem = selectedItem
        self.fine = traficFineDubaiPolice
        self.billMin = billMin
        self.billMax = billMax
        self.billDueAmount = billDueAmount
        self.transactionId = transactionId
        self.accountNumber = accountNumber
        self.denominations = denominations
        self.pin = pin
    }
}

protocol AddBillsEnterAmountViewProtocol: ViperView {
    func setupUI()
    func updateDefaultAmout(value: String)
    func updateNotes(text: String)
}

protocol AddBillsEnterAmountPresenterProtocol: ViperPresenter {
    
    var inPutParameters:BillAccountDetailsParameters? { get set }
    var billDueAmount:String? { get set }
    
    func loadData()
    func navigateToBillCheckOutScreen()
    
}

protocol AddBillsEnterAmountInteractorProtocol: ViperInteractor {
    
  
    
}

protocol AddBillsEnterAmountInteractorOutputProtocol: AnyObject {
    
}

protocol AddBillsEnterAmountRouterProtocol: ViperRouter {
    func go(to route: AddBillsEnterAmountRouter.Route)
}
