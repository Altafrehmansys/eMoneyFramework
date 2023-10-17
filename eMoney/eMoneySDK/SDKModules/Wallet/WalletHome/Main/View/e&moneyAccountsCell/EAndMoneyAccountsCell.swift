//
//  EAndMoneyAccountsCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//

import UIKit

class EAndMoneyAccountsCell: StandardCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountTypeLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? EAndMoneyAccountsCellModel {
            
            self.cardImageView.image = UIImage(named:model.cardImage) 
            self.accountTypeLabel.text = model.accountType
            self.nameLabel.text = model.name
            self.cardNumberLabel.text = model.cardNumber
            self.balanceLabel.text = model.accountBalance
        }
    }
    func setUpUI() {
        
        accountTypeLabel.font = AppFont.appSemiBold(size:.body3)
        accountTypeLabel.textColor = AppColor.eAnd_Black_80
        
        nameLabel.font = AppFont.appRegular(size:.body4)
        nameLabel.textColor = AppColor.eAnd_Grey_70
        
        cardNumberLabel.font = AppFont.appRegular(size:.body4)
        cardNumberLabel.textColor = AppColor.eAnd_Grey_70
        
        balanceLabel.font = AppFont.appRegular(size:.body4)
        balanceLabel.textColor = AppColor.eAnd_Black_80
        
    }
    
}

// MARK: - Cell Model
final class EAndMoneyAccountsCellModel: StandardCellModel {
    
    let cardImage: String
    let accountType: String
    let name: String
    let cardNumber:String
    let accountBalance: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         cardImage: String,
         accountType: String,
         name: String,
         cardNumber:String,
         accountBalance: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.cardImage = cardImage
        self.accountType = accountType
        self.name = name
        self.cardNumber = cardNumber
        self.accountBalance = accountBalance
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return EAndMoneyAccountsCell.identifier()
    }
}

