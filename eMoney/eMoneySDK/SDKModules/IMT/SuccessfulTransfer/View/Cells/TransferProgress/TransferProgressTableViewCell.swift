//
//  TransferProgressTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 07/06/2023.
//

import UIKit

class TransferProgressTableViewCell: StandardCell {

    @IBOutlet weak var imageViewArrow: UIImageView!
    @IBOutlet weak var imageViewProgress: UIImageView!
    @IBOutlet weak var labelInprogress: UILabel!
    @IBOutlet weak var viewInProgress: UIView!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var labelTrackingLink: UILabel!
    @IBOutlet weak var labelTransferStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextAndInterface()
    }
    
    func setTextAndInterface(){
        labelInprogress.text = "inprogress".localized
        labelInprogress.textColor = AppColor.eAnd_Warning_100
        labelInprogress.font = AppFont.appRegular(size: .body4)
        
        labelTrackingLink.text = "tracking_link".localized
        labelTrackingLink.textColor = AppColor.eAnd_Grey_100
        labelTrackingLink.font = AppFont.appRegular(size: .body4)
        
        labelTransferStatus.text = "transfer_status".localized
        labelTransferStatus.textColor = AppColor.eAnd_Black_80
        labelTransferStatus.font = AppFont.appSemiBold(size: .body2)
        
        self.viewContent.clipsToBounds = true
        self.viewContent.layer.cornerRadius = 12
        self.viewContent.layer.borderWidth = 1
        self.viewContent.layer.borderColor = AppColor.eAnd_Grey_100.cgColor
    }
    

    @IBAction func buttonArrowTapped(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? TransferProgressTableViewCellModel {
            labelInprogress.text = model.status
            labelTrackingLink.text = model.desc
        }
    }
    
}

// MARK: - Cell model

final class TransferProgressTableViewCellModel: StandardCellModel {

    let status: String
    let desc: String
   
    init(actions: StandardCellModel.ActionsType = nil, status: String, desc: String) {
        self.status = status
        self.desc = desc
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return TransferProgressTableViewCell.identifier()
    }
}
