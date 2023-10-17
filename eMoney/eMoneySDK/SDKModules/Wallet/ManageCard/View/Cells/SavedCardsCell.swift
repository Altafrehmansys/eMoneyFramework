//
//  SavedCardsCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//

import UIKit

class SavedCardsCell: StandardCell {

    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var radioCheckBox: UIImageView!
 
    override func configureCell() {
        setUpUI()
        if let model = self.cellModel as? SavedCardsCellModel {
            cardImgView.image = UIImage(named: model.cardImage)
            cardTypeLabel.text = model.cardType
            cardNumberLabel.text = model.cardNumber
            if model.isSelectedCard{
                radioCheckBox.image = UIImage(named:"radio_selected")
            }else{
                radioCheckBox.image = UIImage(named:"radio_unselected")
            }
        }
    }
    

    private func setUpUI(){
        cardTypeLabel.font = AppFont.appRegular(size: .body3)
        cardTypeLabel.textColor = AppColor.eAnd_Black_80
        cardNumberLabel.font = AppFont.appRegular(size: .body4)
        cardNumberLabel.textColor = AppColor.eAnd_Grey_100
    }
    
}

class SavedCardsCellModel: StandardCellModel {
    let isSelectedCard:Bool
    let cardImage:String
    let cardType:String
    let cardNumber:String
    let methodType: MethodOptionsBaseTypes?
    init(actions:StandardCellActions? = nil,
         isSelectedCard:Bool,
         cardImage:String,
         cardType:String,
         cardNumber:String,
         methodType:MethodOptionsBaseTypes? = nil) {
        self.isSelectedCard = isSelectedCard
        self.cardImage = cardImage
        self.cardType = cardType
        self.cardNumber = cardNumber
        self.methodType = methodType
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return SavedCardsCell.identifier()
    }
}
