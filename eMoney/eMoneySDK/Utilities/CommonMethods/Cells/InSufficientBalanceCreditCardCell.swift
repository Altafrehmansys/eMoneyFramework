//
//  InSufficientBalanceCreditCardCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/07/2023.
//

import UIKit

class InSufficientBalanceCreditCardCell: StandardCell {

    @IBOutlet weak var rightButton: BaseButton!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardImgView: UIImageView!

    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? InSufficientBalanceCreditCardCellModel {
            self.cardImgView.image = UIImage(named:model.cardImage)
            self.cardTypeLabel.text = model.cardType
            self.cardNumberLabel.text = model.cardNumber
            self.rightButton.setTitle(model.trailingButtonTitle, for: .normal)
        }
    }
    
    func setUpUI() {
        cardTypeLabel.font = AppFont.appRegular(size:.body3)
        cardTypeLabel.textColor = AppColor.eAnd_Black_80
        
        cardNumberLabel.font = AppFont.appRegular(size:.body4)
        cardNumberLabel.textColor = AppColor.eAnd_Grey_100
        rightButton.type = .PlainButton
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
    }
  
    
}

// MARK: - Cell Model
final class InSufficientBalanceCreditCardCellModel: StandardCellModel {
    
    let cardImage: String
    let cardType: String
    let cardNumber:String
    let trailingButtonTitle:String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         cardImage: String,
         cardType: String,
         cardNumber:String,
         trailingButtonTitle:String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.cardImage = cardImage
        self.cardType = cardType
        self.cardNumber = cardNumber
        self.trailingButtonTitle = trailingButtonTitle
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return InSufficientBalanceCreditCardCell.identifier()
    }
}
