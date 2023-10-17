//
//  AccountProfileCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 26/05/2023.
//

import UIKit

class AccountProfileCell: StandardCell {
    @IBOutlet weak var avatarImageView:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblNumber:UILabel!
    override func configureCell() {
        if let model = cellModel as? AccountProfileCellModel {
            self.setupUI()
            self.backgroundColor = AppColor.eAnd_Grey_10
            if let url = URL(string: model.avatar) {
                self.avatarImageView.load(url: url)
            }
            if let name = model.name,
               name.isEmpty == false{
                self.lblName.text = model.name
                self.lblName.textColor = model.nameColor
                self.lblName.font = model.nameFont
            }else{
                self.lblName.isHidden = true
            }
            if let number = model.number,
               number.isEmpty == false {
                self.lblNumber.text = model.number
                self.lblNumber.textColor = model.numberColor
                self.lblNumber.font = model.numberFont
            }else {
                self.lblNumber.isHidden = true
            }
        }
    }
    private func setupUI() {
        self.avatarImageView.cornerRadius = self.avatarImageView.bounds.height / 2
    }
    
}

// MARK: - Cell Model
final class AccountProfileCellModel: StandardCellModel {
    let avatar:String
    
    let name:String?
    let nameColor:UIColor
    let nameFont:UIFont
    
    let number:String?
    let numberColor:UIColor
    let numberFont:UIFont
    
    init(actions: StandardCellModel.ActionsType = nil,avatar: String,
         name: String?,
         nameColor: UIColor = AppColor.eAnd_Black_80,
         nameFont:UIFont  = AppFont.appRegular(size: .body3),
         number: String?,
         numberColor: UIColor = AppColor.eAnd_Grey_100,
         numberFont: UIFont = AppFont.appRegular(size: .body4)) {
        self.avatar = avatar
        
        self.name = name
        self.nameColor = nameColor
        self.nameFont = nameFont
        
        self.number = number
        self.numberColor = numberColor
        self.numberFont = numberFont
        
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return AccountProfileCell.identifier()
    }
}
