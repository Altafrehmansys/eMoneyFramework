//
//  BillSelectAirtimCellModel.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//

import Foundation

class BillSelectAirtimCellModel: StandardCellModel {
    let amount: String
    let secondAmount: String
    let iconImage: String
    
    init(amount: String, secondAmount: String, iconImage: String) {
        self.amount = amount
        self.secondAmount = secondAmount
        self.iconImage = iconImage
    }
    
    override func reusableIdentifier() -> String {
        return "\(BillSelectPlanAiretimeSelectAmonutCollectionViewCell.self)"
    }
}
