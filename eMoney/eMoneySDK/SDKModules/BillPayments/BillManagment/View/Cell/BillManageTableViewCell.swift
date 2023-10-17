//
//  BillManageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//

import UIKit

class BillManageTableViewCell: StandardCell {
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnManage: UIButton!
    @IBOutlet weak var cellParentView: UIView!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? BillManageTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            
            subTitleLabel.text = model.subtitle
            subTitleLabel.font = model.subTitleFont
            subTitleLabel.textColor = model.subTitleColor
        }
    }
    func setUpUI(){
        cellParentView.backgroundColor = AppColor.eAnd_Grey_10
        cellParentView.cornerRadius =   16
        btnManage.titleLabel?.font = AppFont.appMedium(size: .body4)
        btnManage.setTitleColor(AppColor.eAnd_Red_100, for: .normal)
    }
}


// MARK: - Cell Model
final class BillManageTableViewCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    
    let subtitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appRegular(size: .body3),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         subTitle: String,
         subTitleFont: UIFont = AppFont.appRegular(size: .body3),
         subTitleColor: UIColor = AppColor.eAnd_Black_80) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subtitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BillManageTableViewCell.identifier()
    }
    
}
