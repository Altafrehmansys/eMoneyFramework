//
//  MyBeneficiaryTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//

import UIKit

class MyBeneficiaryTableViewCell: StandardCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagChildView: UIView!
    @IBOutlet weak var tabParentView: UIView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImgView: UIImageView!
    override func configureCell() {
        tagChildView.layer.cornerRadius = 10
        if let model = cellModel as? MyBeneficiaryTableViewCellModel {
            
            profileImgView.image = UIImage(named: model.profileImage)
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            
            subTitleLabel.text = model.subTitle
            subTitleLabel.font = model.subTitleFont
            subTitleLabel.textColor = model.subTitleColor
            
            if model.isEmployee{
                tabParentView.isHidden = false
                tagLabel.text = model.tagTitle
                tagLabel.font = model.tagTitleFont
                tagLabel.textColor = model.tagTitleColor
            }else{
                tabParentView.isHidden = true
            }
           
            
        }
    }
    
}
// MARK: - Cell Model
final class MyBeneficiaryTableViewCellModel: StandardCellModel {
    
    let profileImage:String
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    
    let subTitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    
    let isEmployee:Bool
    let tagTitle: String?
    let tagTitleFont:UIFont?
    let tagTitleColor:UIColor?
    
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         isEmployee:Bool,
         profileImage:String,
         title: String,
         titleFont: UIFont = AppFont.appRegular(size: .body3),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         subTitle:String,
         subTitleFont:UIFont = AppFont.appRegular(size: .body4),
         subTitleColor:UIColor = AppColor.eAnd_Grey_100,
         tagTitle:String? = nil,
         tagTitleFont:UIFont? = AppFont.appLight(size:.body4),
         tagTitleColor:UIColor? = AppColor.eAnd_Maroon,methodType: MethodOptionsBaseTypes? = nil) {
        
        self.isEmployee = isEmployee
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        
        self.profileImage = profileImage
        
        self.tagTitle = tagTitle
        self.tagTitleFont = tagTitleFont
        self.tagTitleColor = tagTitleColor
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return MyBeneficiaryTableViewCell.identifier()
    }
}
