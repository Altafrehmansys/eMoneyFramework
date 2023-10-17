//
//  TransferExpandedTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 08/06/2023.
//

import UIKit

class TransferExpandedTableViewCell: StandardCell {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelFullName: UILabel!
    @IBOutlet weak var labelTransferDetails: UILabel!
    
    @IBOutlet weak var labelMethod: UILabel!
    
    @IBOutlet weak var labelMethodType: UILabel!
    @IBOutlet weak var labelIban: UILabel!
    
    @IBOutlet weak var labelTheyRecieve: UILabel!
    
    @IBOutlet weak var labelCurrencyValue: UILabel!
    
    @IBOutlet weak var labelConversionValue: UILabel!
    
    @IBOutlet weak var labelYouSent: UILabel!
    
    @IBOutlet weak var labelSentValue: UILabel!
    
    @IBOutlet weak var labelFees: UILabel!
    
    @IBOutlet weak var viewPromo: UIView!
    
    @IBOutlet weak var labelPromo: UILabel!
    @IBOutlet weak var labelFeesValue: UILabel!
    @IBOutlet weak var labelTransId: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTransIdValue: UILabel!
    @IBOutlet weak var labelPaymentValue: UILabel!
    @IBOutlet weak var labelPayment: UILabel!
    @IBOutlet weak var labelFeesDiscount: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelDateValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextAndView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setTextAndView(){
        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 12
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
    }
    
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? TransferExpandedTableViewCellModel {
            labelDateValue.text = model.date
            labelTransIdValue.text = model.transactionId
            labelName.text = model.fullname
        }
    }
    
}

// MARK: - Cell model

final class TransferExpandedTableViewCellModel: StandardCellModel {

    let fullname: String
    let method: String
    let iban: String
    let recieveAmount: String
    let sentAmount: String
    let fees: String
    let totalPayment: String
    let transactionId: String
    let date: String
    var isExpanded = true
   
    init(actions: StandardCellModel.ActionsType = nil, fullname: String,method : String,iban : String,recieveAmount : String,sentAmount : String,fees : String,totalPayment : String,transactionId : String,date : String,isExpanded : Bool) {
        
        self.fullname = fullname
        self.method = method
        self.iban = iban
        self.recieveAmount = recieveAmount
        self.sentAmount = sentAmount
        self.fees = fees
        self.totalPayment = totalPayment
        self.transactionId = transactionId
        self.date = date
        self.isExpanded = isExpanded
        
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TransferExpandedTableViewCell.identifier()
    }
}
