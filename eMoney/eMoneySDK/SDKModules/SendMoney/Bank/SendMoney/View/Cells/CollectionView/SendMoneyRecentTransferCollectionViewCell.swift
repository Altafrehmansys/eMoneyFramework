//
//  SendMoneyRecentTransferCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/05/2023.
//

import UIKit

class SendMoneyRecentTransferCollectionViewCell: StandardCollectionViewCell {
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        profileImgView.cornerRadius = profileImgView.viewWidth/2
        nameLabel.font = AppFont.appRegular(size: .body3)
        nameLabel.textColor = AppColor.eAnd_Black_80
        accountLabel.font = AppFont.appRegular(size: .body4)
        accountLabel.textColor = AppColor.eAnd_Grey_100
       
        amountLabel.font = AppFont.appSemiBold(size: .body3)
        amountLabel.textColor = AppColor.eAnd_Black_80
        
        cellParentView.cornerRadius = 12
        cellParentView.borderColor = AppColor.eAnd_Grey_20
        cellParentView.borderWidth = 1
        cellParentView.addShadow(shadowOpacity: 1, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 1), shadowColor: AppColor.eAnd_Shadow)
        
    }
    
    override func configureCell() {
        if let model = cellModel as? SendMoneyRecentTransferCollectionViewCellModel {
            nameLabel.text = model.name
            amountLabel.text = model.amount
            profileImgView.image = UIImage(named: model.image)
        }
    }

}
// MARK: - ServiceCollectionViewCellModel
final class SendMoneyRecentTransferCollectionViewCellModel: StandardCellModel {
    let name: String
    let amount:String
    let account:String
    let image: String
    
    init(actions: StandardCellModel.ActionsType = nil,
         name: String,
         amount:String,
         account:String,
         image: String)
    {
        self.name = name
        self.image = image
        self.amount = amount
        self.account = account
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SendMoneyRecentTransferCollectionViewCell.identifier()
    }
}
