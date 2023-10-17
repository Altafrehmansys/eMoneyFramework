//
//  EmployeeBeneficiaryManageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//

import UIKit

class EmployeeBeneficiaryManageTableViewCell: StandardCell {

    @IBOutlet weak var btnManage: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cellParentView: UIView!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? EmployeeBeneficiaryManageTableViewCellModel {
            messageLabel.text = model.message
            messageLabel.font = model.messageFont
            messageLabel.textColor = model.messageColor
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
final class EmployeeBeneficiaryManageTableViewCellModel: StandardCellModel {
    
    let message: String
    let messageFont:UIFont
    let messageColor:UIColor
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         message: String,
         messageFont: UIFont = AppFont.appRegular(size: .body3),
         messageColor: UIColor = AppColor.eAnd_Black_80) {
        self.message = message
        self.messageFont = messageFont
        self.messageColor = messageColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return EmployeeBeneficiaryManageTableViewCell.identifier()
    }
    
    
}
