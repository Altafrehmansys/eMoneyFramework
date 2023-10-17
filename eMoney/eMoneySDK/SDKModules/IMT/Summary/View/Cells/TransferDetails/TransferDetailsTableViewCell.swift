//
//  TransferDetailsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 24/05/2023.
//

import UIKit

class TransferDetailsTableViewCell: StandardCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var labelBankMethod: UILabel!
    @IBOutlet weak var labelTotalPayment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewOuter.clipsToBounds = true
        self.viewOuter.layer.cornerRadius = 12
        self.viewOuter.layer.borderWidth = 1
        self.viewOuter.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? TransferDetailsTableViewCellModel {
            labelBankMethod.text = model.deliveryMethod
            labelTotalPayment.text = model.totalPayment
            
        }
    }
    
}

// MARK: - Cell model

final class TransferDetailsTableViewCellModel: StandardCellModel {

    let deliveryMethod: String
    let recieveAmount: String
    let convertedAmount: String
    let sendAmount: String
    let fees: String
    let totalPayment: String
    let hasPromo: Bool
    
   
    init(actions: StandardCellModel.ActionsType = nil,
         deliveryMethod: String,
         recieveAmount: String,
         convertedAmount: String,
         sendAmount: String,
         fees: String,
         totalPayment: String,
         hasPromo: Bool) {
        self.deliveryMethod = deliveryMethod
        self.recieveAmount = recieveAmount
        self.convertedAmount = convertedAmount
        self.sendAmount = sendAmount
        self.fees = fees
        self.totalPayment = totalPayment
        self.hasPromo = hasPromo
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TransferDetailsTableViewCell.identifier()
    }
}
