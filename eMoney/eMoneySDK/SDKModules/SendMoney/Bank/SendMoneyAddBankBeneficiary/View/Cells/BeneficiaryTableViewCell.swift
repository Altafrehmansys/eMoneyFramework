//
//  BeneficiaryTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//

import UIKit

class BeneficiaryTableViewCell: StandardCell {

    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var iBANNumberLabel: UILabel!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankImgView: UIImageView!
    @IBOutlet weak var beneficiaryNameLabel: UILabel!
  
    override func configureCell() {
        if let model = cellModel as? BeneficiaryCellModel {
            beneficiaryNameLabel.text = model.beneficiaryName
            beneficiaryNameLabel.font = model.beneficiaryNameFont
            beneficiaryNameLabel.textColor = model.beneficiaryNameColor
            
            bankNameLabel.text = model.bankName
            bankNameLabel.font = model.bankNameFont
            bankNameLabel.textColor = model.bankNameColor
            
            iBANNumberLabel.text = model.bankIBANNumber
            iBANNumberLabel.font = model.bankIBANNumberFont
            iBANNumberLabel.textColor = model.bankIBANNumberColor
        }
        cellParentView.layer.cornerRadius = 12
        cellParentView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        cellParentView.layer.borderWidth = 1
    }
    
}


// MARK: - Cell Model
final class BeneficiaryCellModel: StandardCellModel {
    
    let beneficiaryName: String
    let beneficiaryNameFont:UIFont
    let beneficiaryNameColor:UIColor
    
    let bankImage: String
    
    let bankName: String
    let bankNameFont:UIFont
    let bankNameColor:UIColor
    
    let bankIBANNumber:String
    let bankIBANNumberFont:UIFont
    let bankIBANNumberColor:UIColor
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         beneficiaryName: String,
         beneficiaryNameFont: UIFont = AppFont.appSemiBold(size: .body3),
         beneficiaryNameColor: UIColor = AppColor.eAnd_Black_80,bankImage:String,bankName:String,bankNameFont:UIFont = AppFont.appRegular(size: .body4),bankNameColor:UIColor = AppColor.eAnd_Black_80,bankIBANNumber:String,bankIBANNumberFont:UIFont = AppFont.appRegular(size: .body4),bankIBANNumberColor:UIColor = AppColor.eAnd_Grey_100,methodType: MethodOptionsBaseTypes? = nil) {
        
        self.beneficiaryName = beneficiaryName
        self.beneficiaryNameFont = beneficiaryNameFont
        self.beneficiaryNameColor = beneficiaryNameColor
        
        self.bankImage = bankImage
        
        self.bankName = bankName
        self.bankNameFont = bankNameFont
        self.bankNameColor = bankNameColor
        
        self.bankIBANNumber = bankIBANNumber
        self.bankIBANNumberFont = bankNameFont
        self.bankIBANNumberColor = bankIBANNumberColor
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BeneficiaryTableViewCell.identifier()
    }
}
// MARK: - Methods Base type
//class MethodOptionsBaseTypes { }
