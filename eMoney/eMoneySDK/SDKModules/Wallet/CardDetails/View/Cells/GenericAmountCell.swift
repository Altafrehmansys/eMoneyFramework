//
//  GenericAmountCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 10/07/2023.
//

import UIKit

class GenericAmountCell: StandardCell {
    @IBOutlet weak var amountField:BaseAmountField!
    override func configureCell() {
        if let model = self.cellModel as? GenericAmountCellModel {
            self.amountField.fieldTypeEnum = .enable
            self.amountField.isUserInteractionEnabled = model.isEnabled
            self.amountField.currentColor = model.amountColor
            self.amountField.settingView(desc: "")
            self.amountField.text = model.amount
            self.amountField.textChangedCallback = {
                model.amount = self.amountField.amount ?? "0"
            }
        }
    }
}
final class GenericAmountCellModel:StandardCellModel {
    var amount:String
    let amountFont:UIFont
    let amountColor:UIColor
    
    let isEnabled:Bool
    
    init(actions: StandardCellModel.ActionsType = nil,
         amount:String,
         amountFont:UIFont = AppFont.appSemiBold(size: .h4),
         amountColor:UIColor = AppColor.eAnd_Black_80,
         isEnabled:Bool = true)
    {
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        self.isEnabled = isEnabled
        super.init(actions:actions)
    }
    override func reusableIdentifier() -> String {
        return GenericAmountCell.identifier()
    }
}
