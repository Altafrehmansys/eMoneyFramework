//
//  SavedAccountCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/07/2023.
//

import UIKit

class SavedAccountCell: StandardCell {

    
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SavedAccountCellModel {
            
            self.imgView.image = UIImage(named:model.cardImage)
            self.accountLabel.text = model.account
            self.cardNumberLabel.text = model.cardNumber
        }
    }
    
    func setUpUI() {
        cardNumberLabel.font = AppFont.appRegular(size:.body4)
        cardNumberLabel.textColor = AppColor.eAnd_Grey_100
        accountLabel.font = AppFont.appRegular(size:.body4)
        accountLabel.textColor = AppColor.eAnd_Black_80
    }
}


// MARK: - Cell Model
final class SavedAccountCellModel: StandardCellModel {
    
    let cardImage: String
    let account: String
    let cardNumber:String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         cardImage: String,
         account: String,
         cardNumber:String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.cardImage = cardImage
        self.account = account
        self.cardNumber = cardNumber
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SavedAccountCell.identifier()
    }
}
