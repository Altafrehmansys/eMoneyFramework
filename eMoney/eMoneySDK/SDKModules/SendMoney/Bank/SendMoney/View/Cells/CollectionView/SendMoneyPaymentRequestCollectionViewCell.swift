//
//  SendMoneyPaymentRequestCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/05/2023.
//

import UIKit

class SendMoneyPaymentRequestCollectionViewCell: StandardCollectionViewCell {
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagImgView: UIImageView!
    
    @IBOutlet weak var tagParentView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.cornerRadius =   profileImgView.viewWidth/2
        tagParentView.layer.cornerRadius = 4
        nameLabel.font = AppFont.appRegular(size: .body3)
        nameLabel.textColor = AppColor.eAnd_Black_80
        amountLabel.font = AppFont.appRegular(size: .body4)
        amountLabel.textColor = AppColor.eAnd_Grey_100
        
//        cellParentView.addGradient(colors:[AppColor.linearGradientStart,AppColor.linearGradientEnd], locations: [0, 1], startPoint: CGPoint(x: 0.25, y: 0.5), endPoint:  CGPoint(x: 0.75, y: 0.5))
        cellParentView.backgroundColor = AppColor.linearGradientEnd
      //  cellParentView.addShadow(shadowOpacity: 1, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 1), shadowColor: AppColor.eAnd_Shadow)
        cellParentView.layer.cornerRadius = 16
       

    }
    override func layoutSubviews() {
        super.layoutSubviews()
       // cellParentView.addGradient(colors:[AppColor.linearGradientStart,AppColor.linearGradientEnd], locations: [0, 1], startPoint: CGPoint(x: 0.25, y: 0.5), endPoint:  CGPoint(x: 0.75, y: 0.5))
    }
    override func configureCell() {
        if let model = cellModel as? SendMoneyPaymentRequestCollectionViewCellModel {
            nameLabel.text = model.name
            amountLabel.text = model.amount
            profileImgView.image = UIImage(named: model.image)
        }
    }

}

// MARK: - ServiceCollectionViewCellModel
final class SendMoneyPaymentRequestCollectionViewCellModel: StandardCellModel {
    let name: String
    let amount:String
    let image: String
    
    init(actions: StandardCellModel.ActionsType = nil,
         name: String,
         amount:String,
         image: String)
    {
        self.name = name
        self.image = image
        self.amount = amount
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SendMoneyPaymentRequestCollectionViewCell.identifier()
    }
}


