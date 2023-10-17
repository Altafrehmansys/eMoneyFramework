//
//  TransferProcessingTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 07/06/2023.
//

import UIKit

class TransferProcessingTableViewCell: StandardCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var imageViewCreditBank: UIImageView!
    @IBOutlet weak var imageViewRecieveBank: UIImageView!
    @IBOutlet weak var imageViewRecipentBank: UIImageView!
    @IBOutlet weak var imageViewProcess: UIImageView!
    @IBOutlet weak var imageViewRecipent: UIImageView!
    @IBOutlet weak var labelRecieveBankTime: UILabel!
    @IBOutlet weak var labelRecipentBankTime: UILabel!
    @IBOutlet weak var labelRecipentBankDesc: UILabel!
    @IBOutlet weak var labelProcessStatus: UILabel!
    @IBOutlet weak var labelCreditBank: UILabel!
    @IBOutlet weak var labelRecieveBank: UILabel!
    @IBOutlet weak var labelSentBank: UILabel!
    @IBOutlet weak var viewRecipent: UIView!
    @IBOutlet weak var labelEmoneyProcessing: UILabel!
    
    @IBOutlet weak var viewRecieve: UIView!
    @IBOutlet weak var viewProcess: UIView!
    @IBOutlet weak var labelCreditBankDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextAndInterface()
    }
    func setTextAndInterface(){
        labelEmoneyProcessing.text = "emoney_process".localized
        labelEmoneyProcessing.textColor = AppColor.eAnd_Black_80
        labelEmoneyProcessing.font = AppFont.appSemiBold(size: .body3)
        labelSentBank.text = "sent_recipent".localized
        labelSentBank.textColor = AppColor.eAnd_Black_80
        labelSentBank.font = AppFont.appSemiBold(size: .body3)
        labelRecieveBank.text = "rec_recipent".localized
        labelRecieveBank.textColor = AppColor.eAnd_Black_80
        labelRecieveBank.font = AppFont.appSemiBold(size: .body3)
        labelCreditBank.text = "recipent_credit".localized
        labelCreditBank.textColor = AppColor.eAnd_Black_80
        labelCreditBank.font = AppFont.appSemiBold(size: .body3)
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
        if let model = cellModel as? TransferProcessingTableViewCellModel {
//            labelProcessStatus.text = model.status
//            labelCreditBank.text = model.status
//            labelRecieveBank.text = model.status
//            labelSentBank.text = model.status
          
        }
    }
    
}
// MARK: - Cell model

final class TransferProcessingTableViewCellModel: StandardCellModel {

    let status: String
    let recipentTime: String
    let time: String
    let day: String
    let processingDesc: String
    
    init(actions: StandardCellModel.ActionsType = nil, status: String,recipentTime: String,time: String,day: String,processingDesc: String) {
        self.status = status
        self.recipentTime = recipentTime
        self.time = time
        self.day = day
        self.processingDesc = processingDesc
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TransferProcessingTableViewCell.identifier()
    }
}
