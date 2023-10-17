//
//  TransferStatussTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 07/06/2023.
//

import UIKit

class TransferStatussTableViewCell: StandardCell {
    @IBOutlet weak var labelTransactionId: UILabel!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageViewArrow: UIImageView!
    @IBOutlet weak var labelTransferDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextAndInterface()
    }
    
    func setTextAndInterface(){
        labelTransferDetails.text = "transfer_details".localized
        labelTransferDetails.textColor = AppColor.eAnd_Black_80
        labelTransferDetails.font = AppFont.appSemiBold(size: .body2)
        labelTransactionId.text = "transaction_id".localized
        labelTransactionId.textColor = AppColor.eAnd_Grey_100
        labelTransactionId.font = AppFont.appRegular(size: .body3)
        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 12
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
    }
    
    @IBAction func buttonArrowTapped(_ sender: Any) {
        print("buttonArrowTapped")
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? TransferStatussTableViewCellModel {
            labelTransactionId.text = model.transactionId
          
        }
    }
    
}

// MARK: - Cell model

final class TransferStatussTableViewCellModel: StandardCellModel {

    let transactionId: String
    var isExpanded = false
   
    init(actions: StandardCellModel.ActionsType = nil, transactionId: String,isExpanded : Bool) {
        self.transactionId = transactionId
        self.isExpanded = isExpanded
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TransferStatussTableViewCell.identifier()
    }
}
