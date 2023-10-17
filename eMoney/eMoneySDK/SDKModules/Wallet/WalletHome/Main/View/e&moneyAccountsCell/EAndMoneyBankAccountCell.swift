//
//  EAndMoneyBankAccountCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/07/2023.
//

import UIKit

class EAndMoneyBankAccountCell: StandardCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? EAndMoneyBankAccountCellModel {
            
            self.imgView.image = UIImage(named:model.cardImage)
            self.accountTypeLabel.text = model.accountType
            self.nameLabel.text = model.name
            self.balanceLabel.text = model.accountBalance
        }
    }
    func setUpUI() {
        
        accountTypeLabel.font = AppFont.appSemiBold(size:.body3)
        accountTypeLabel.textColor = AppColor.eAnd_Black_80
        
        nameLabel.font = AppFont.appRegular(size:.body4)
        nameLabel.textColor = AppColor.eAnd_Grey_70
        
        balanceLabel.font = AppFont.appRegular(size:.body4)
        balanceLabel.textColor = AppColor.eAnd_Black_80
        
    }
    
}

// MARK: - Cell Model
final class EAndMoneyBankAccountCellModel: StandardCellModel {
    
    let cardImage: String
    let accountType: String
    let name: String
    let accountBalance: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         cardImage: String,
         accountType: String,
         name: String,
         accountBalance: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.cardImage = cardImage
        self.accountType = accountType
        self.name = name
        self.accountBalance = accountBalance
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return EAndMoneyBankAccountCell.identifier()
    }
}
