//
//  SavedUtilityBillTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 18/05/2023.
//

import UIKit

class SavedUtilityBillTableViewCell: StandardCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
   
    @IBOutlet weak var amountLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SavedUtilityBillTableViewCellModel {
            self.titleLabel.text = model.title
            self.titleLabel.font = model.titleFont
            self.titleLabel.textColor = model.titleColor
            self.subTitleLabel.text = model.subTitle
            self.subTitleLabel.font = model.subTitleFont
            self.subTitleLabel.textColor = model.subTitleColor
            if model.amount != nil{
                amountLabel.isHidden = false
                self.amountLabel.text = model.amount
                self.amountLabel.font = model.amountFont
                self.amountLabel.textColor = model.amountColor
            }else{
                amountLabel.isHidden = true
                
            }
        }
    }
    func setUpUI() {
      
    }
}

// MARK: - Cell Model
final class SavedUtilityBillTableViewCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    let subTitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    
    let amount: String?
    let amountFont:UIFont?
    let amountColor:UIColor?
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appRegular(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         
         subTitle: String,
         subTitleFont: UIFont = AppFont.appMedium(size: .body3),
         subTitleColor: UIColor = AppColor.eAnd_Grey_70,
         amount: String? = nil,
         amountFont: UIFont = AppFont.appMedium(size: .body4),
         amountColor: UIColor = AppColor.eAnd_Black_80,
         
         methodType: MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        self.methodType = methodType
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SavedUtilityBillTableViewCell.identifier()
    }
}
