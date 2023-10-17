//
//  AddNewBeneficiaryTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//

import UIKit

class AddNewBeneficiaryTableViewCell: StandardCell {

    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var addImgView: UIImageView!
    @IBOutlet weak var addBankRecipientLabel: UILabel!
    @IBOutlet weak var newBeneficiaryLabel: UILabel!
   
    override func configureCell() {
        if let model = cellModel as? AddNewBeneficiaryCellModel {
            
            newBeneficiaryLabel.text = model.title
            newBeneficiaryLabel.font = model.titleFont
            newBeneficiaryLabel.textColor = model.titleColor
            
            addBankRecipientLabel.text = model.subTitle
            addBankRecipientLabel.font = model.subTitleFont
            addBankRecipientLabel.textColor = model.subTitleColor
            
            cellParentView.backgroundColor = model.backgroundColor
        }
        cellParentView.layer.cornerRadius = 16
    }
    
}

// MARK: - Cell Model
final class AddNewBeneficiaryCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor

    let subTitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    let methodType: MethodOptionsBaseTypes?
    
    let backgroundColor: UIColor
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         subTitle:String,
         subTitleFont:UIFont = AppFont.appRegular(size: .body2),
         subTitleColor:UIColor = AppColor.eAnd_Black_80,
         methodType: MethodOptionsBaseTypes? = nil,
         backgroundColor: UIColor = AppColor.eAnd_Baige) {
        
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        self.methodType = methodType
        self.backgroundColor = backgroundColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewBeneficiaryTableViewCell.identifier()
    }
}
