//
//  BillSelectDataCellModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//

import Foundation


class BillSelectDataCellModel: StandardCellModel {
    
    let quota: String
    let validationDate: String?
    let senderAmount: String?
    let reciveAmount: String?
    let amountCurrency: String?
    
    init(quota: String, senderAmount: String, reciveAmount: String,  validationDate: String, amountCurrency: String) {
        self.senderAmount = senderAmount
        self.reciveAmount = reciveAmount
        self.quota = quota
        self.validationDate = validationDate
        self.amountCurrency = amountCurrency
    }
    
    override func reusableIdentifier() -> String {
        return "\(BillSelectPlanDataCollectionViewCell.self)"
    }
}
