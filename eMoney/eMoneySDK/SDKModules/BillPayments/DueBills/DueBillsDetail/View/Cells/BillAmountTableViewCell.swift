//
//  BillAmountTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//

import UIKit

class BillAmountTableViewCell: StandardCell {

    @IBOutlet weak var lblAmount: UILabel!
   
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? BillAmountTableViewCellModel {
            self.lblAmount.text = model.amount
        }
    }
    func setUpUI() {
        lblAmount.font = AppFont.appSemiBold(size: .body1)
        lblAmount.textColor = AppColor.eAnd_Black_80
        
    }
}

class BillAmountTableViewCellModel:StandardCellModel{
    
    let amount: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         amount: String,
         methodType:MethodOptionsBaseTypes? = nil) {
        self.amount = amount
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BillAmountTableViewCell.identifier()
    }
}
