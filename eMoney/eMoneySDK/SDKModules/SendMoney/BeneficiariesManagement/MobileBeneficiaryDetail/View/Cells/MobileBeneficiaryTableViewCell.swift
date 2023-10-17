//
//  MobileBeneficiaryTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/05/2023.
//

import UIKit

class MobileBeneficiaryTableViewCell: StandardCell {

    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cellParentView: UIView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? MobileBeneficiaryTableViewCellModel {
            statusLabel.text = model.message
            statusLabel.font = model.messageFont
            statusLabel.textColor = model.messageColor
            
            timeLabel.text = model.time
            timeLabel.font = model.timeFont
            timeLabel.textColor = model.timeColor
            
            amountLabel.text = model.amount
            amountLabel.font = model.amountFont
            amountLabel.textColor = model.amountColor
            
            if model.notes != nil{
                notesLabel.text = model.notes
                notesLabel.font = model.notesFont
                notesLabel.textColor = model.notesColor
                notesLabel.isHidden = false
            }else{
                notesLabel.isHidden = true
            }
           
        }
    }
    func setUpUI(){
        cellParentView.cornerRadius =   12
    }
    
}

// MARK: - Cell Model
final class MobileBeneficiaryTableViewCellModel: StandardCellModel {
    
    let message: String
    let messageFont:UIFont
    let messageColor:UIColor
    
    let time: String
    let timeFont:UIFont
    let timeColor:UIColor
    
    let amount: String
    let amountFont:UIFont
    let amountColor:UIColor
    
    let notes: String?
    let notesFont:UIFont?
    let notesColor:UIColor?
    
    init(actions: StandardCellModel.ActionsType = nil,
         message: String,
         messageFont: UIFont = AppFont.appSemiBold(size: .body2),
         messageColor: UIColor = AppColor.eAnd_Black_80,
         time: String,
         timeFont: UIFont = AppFont.appRegular(size: .body5),
         timeColor: UIColor = AppColor.eAnd_Black_80,
         amount: String,
         amountFont: UIFont = AppFont.appSemiBold(size: .body3),
         amountColor: UIColor = AppColor.eAnd_Black_80,
         notes: String? = nil,
         notesFont: UIFont = AppFont.appRegular(size: .body5),
         notesColor: UIColor =  AppColor.eAnd_Black_80) {
        self.message = message
        self.messageFont = messageFont
        self.messageColor = messageColor
        
        self.time = time
        self.timeFont = timeFont
        self.timeColor = timeColor
        
        
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        
        self.notes = notes
        self.notesFont = notesFont
        self.notesColor = notesColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return MobileBeneficiaryTableViewCell.identifier()
    }
    
    
}
