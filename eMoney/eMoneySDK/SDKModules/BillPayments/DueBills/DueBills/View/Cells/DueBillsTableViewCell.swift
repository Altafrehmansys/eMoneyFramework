//
//  DueBillsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 25/05/2023.
//

import UIKit

class DueBillsTableViewCell: StandardCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var tagViewOne: UIView!
    @IBOutlet weak var tagTwoLabel: UILabel!
    @IBOutlet weak var tagOneLabel: UILabel!
    @IBOutlet weak var tagOneImgView: UIImageView!
    @IBOutlet weak var tagViewTwo: UIView!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? DueBillsTableViewCellModel {
            self.titleLabel.text = model.title
            self.titleLabel.font = model.titleFont
            self.titleLabel.textColor = model.titleColor
            
            self.subTitleLabel.text = model.subTitle
            self.subTitleLabel.font = model.subTitleFont
            self.subTitleLabel.textColor = model.subTitleColor
            
            
            self.tagViewOne.backgroundColor = model.tagOneBgColor
            self.tagOneLabel.text = model.tagOneTitle
            self.tagOneLabel.font = model.tagTwoTitleFont
            self.tagOneLabel.textColor = model.tagOneTitleColor
            self.tagOneImgView.image = UIImage(named: model.tagOneIcon)
            self.btnCheckBox.setImage(UIImage(named: model.isSelected ?? false ? "checked-icon":"unchecked-icon"), for:.normal)
         
            if model.isTagTwoEnable {
                tagViewTwo.isHidden = false
                tagTwoLabel.text = model.tagTwoTitle
                tagTwoLabel.font = model.tagTwoTitleFont
                tagTwoLabel.textColor = model.tagTwoTitleColor
                tagViewTwo.backgroundColor = model.tagTwoBgColor
            }else{
                tagViewTwo.isHidden = true
            }
            
        }
    }
    func setUpUI() {
        tagViewOne.cornerRadius = 10
        tagViewTwo.cornerRadius = 10
    }
    private func setup() {
        btnCheckBox.addTarget(self, action: #selector(trailingButtonTappedAction(_:)), for: .touchUpInside)
    }
    @objc func trailingButtonTappedAction(_ sender: UIButton) {
        if let cellModel {
            cellModel.actions?.cellSelected(0, cellModel)
        }
    }
}

// MARK: - Cell Model
final class DueBillsTableViewCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    
    let subTitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    
    let tagOneTitle: String
    let tagOneTitleFont:UIFont
    let tagOneTitleColor:UIColor
    let tagOneBgColor:UIColor
    let tagOneIcon:String
    
    let isTagTwoEnable:Bool
    
    let tagTwoTitle: String?
    let tagTwoTitleFont:UIFont?
    let tagTwoTitleColor:UIColor?
    let tagTwoBgColor:UIColor?
    let methodType: MethodOptionsBaseTypes?
    var isSelected:Bool?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appRegular(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         
         subTitle: String,
         subTitleFont: UIFont = AppFont.appMedium(size: .body3),
         subTitleColor: UIColor = AppColor.eAnd_Grey_70,
         
         tagOneTitle: String,
         tagOneTitleFont:UIFont = AppFont.appRegular(size: .body5),
         tagOneTitleColor:UIColor = AppColor.eAnd_Warning_100,
         tagOneBgColor:UIColor = AppColor.eAnd_Warning_10,
         tagOneIcon:String,
         
         isTagTwoEnable:Bool,
         tagTwoTitle: String? = nil,
         tagTwoTitleFont:UIFont? = nil,
         tagTwoTitleColor:UIColor? = nil,
         tagTwoBgColor:UIColor? = nil,methodType: MethodOptionsBaseTypes? = nil,isSelected:Bool? = false) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        self.tagOneTitle = tagOneTitle
        self.tagOneTitleFont = tagOneTitleFont
        self.tagOneTitleColor = tagOneTitleColor
        self.tagOneBgColor = tagOneBgColor
        self.tagOneIcon = tagOneIcon
        self.isTagTwoEnable = isTagTwoEnable
        self.tagTwoTitle = tagTwoTitle
        self.tagTwoTitleFont =  tagTwoTitleFont
        self.tagTwoTitleColor = tagTwoTitleColor
        self.tagTwoBgColor =  tagTwoBgColor
        self.methodType = methodType
        self.isSelected = isSelected
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return DueBillsTableViewCell.identifier()
    }
}
