//
//  TopUpAmountSelectionCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 26/05/2023.
//

import UIKit

class TopUpAmountSelectionCell: StandardCollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    override func configureCell() {
        if let model = cellModel as? TopUpAmountSelectionCellModel {
            self.lblTitle.text = model.amount
            self.lblTitle.textColor = model.amountColor
            self.lblTitle.font = model.amountFont
            
        }
    }
}
final class TopUpAmountSelectionCellModel: StandardCellModel {
    var amount:String
    var amountColor:UIColor
    var amountFont:UIFont
    init(amount: String,
         amountColor: UIColor = AppColor.eAnd_Black_80,
         amountFont: UIFont = AppFont.appRegular(size: .body4)) {
        self.amount = amount
        self.amountColor = amountColor
        self.amountFont = amountFont
    }
    override func reusableIdentifier() -> String {
        return TopUpAmountSelectionCell.identifier()
    }
}
