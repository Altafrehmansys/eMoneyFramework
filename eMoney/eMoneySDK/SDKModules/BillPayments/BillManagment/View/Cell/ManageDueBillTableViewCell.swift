//
//  ManageDueBillTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//

import UIKit

class ManageDueBillTableViewCell: StandardCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cellParentView: UIView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? ManageDueBillTableViewCellModel {
            titleLable.text = model.title
            titleLable.font = model.titleFont
            titleLable.textColor = model.titleColor
            
            subTitleLable.text = model.subTitle
            subTitleLable.font = model.subTitleFont
            subTitleLable.textColor = model.subTitleColor
            
            statusLabel.text = model.status
            statusLabel.font = model.statusFont
            statusLabel.textColor = model.statusColor
            
            amountLabel.text = model.amount
            amountLabel.font = model.amountFont
            amountLabel.textColor = model.amountColor
            
        }
    }
    func setUpUI(){
        cellParentView.cornerRadius =   12
    }
    
}

// MARK: - Cell Model
final class ManageDueBillTableViewCellModel: StandardCellModel {
    
    let title: String
    let titleFont:UIFont
    let titleColor:UIColor
    
    let subTitle: String
    let subTitleFont:UIFont
    let subTitleColor:UIColor
    
    let status: String
    let statusFont:UIFont
    let statusColor:UIColor
    
    let amount: String
    let amountFont:UIFont
    let amountColor:UIColor
    

    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleColor: UIColor = AppColor.eAnd_Black_80,
         subTitle: String,
         subTitleFont: UIFont = AppFont.appRegular(size: .body5),
         subTitleColor: UIColor = AppColor.eAnd_Black_80,
         status: String,
         statusFont: UIFont = AppFont.appSemiBold(size: .body3),
         statusColor: UIColor = AppColor.eAnd_Black_80,
         amount: String,
         amountFont: UIFont = AppFont.appRegular(size: .body5),
         amountColor: UIColor =  AppColor.eAnd_Black_80) {
        
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        
        
        self.status = status
        self.statusFont = statusFont
        self.statusColor = statusColor
        
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ManageDueBillTableViewCell.identifier()
    }
    
    
}
