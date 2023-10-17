//
//  CardCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 11/07/2023.
//

import UIKit

class CardCell: StandardCell {
    @IBOutlet weak var brandImage:UIImageView!
    @IBOutlet weak var cardBGImage:UIImageView!
    
    @IBOutlet weak var lblCardNo:UILabel!
    @IBOutlet weak var btnCopyCardNo:UIButton!
    
    @IBOutlet weak var lblExpiryTitle:UILabel!
    @IBOutlet weak var lblExpiry:UILabel!
    
    @IBOutlet weak var lblCVVTitle:UILabel!
    @IBOutlet weak var lblCVV:UILabel!
    
    @IBOutlet weak var lblCardTitle:UILabel!
    @IBOutlet weak var btnCopyCardTitle:UIButton!
    
    @IBOutlet weak var cardTypeImage:UIImageView!
    
    override func configureCell() {
        if let model = self.cellModel as? CardCellModel {
            self.brandImage.image = UIImage(named:model.cardBrandImage)
            self.cardBGImage.image = UIImage(named:model.cardBGImage)
            
            self.lblCardNo.text = model.cardNo
            self.lblCardNo.font = model.cardNoFont
            self.lblCardNo.textColor = model.cardNoColor
            self.btnCopyCardNo.isHidden = !model.allowCopyCardNo
            
            self.lblExpiryTitle.text = Strings.Wallet.expiry
            self.lblExpiryTitle.font = model.cardExpiryFont
            self.lblExpiryTitle.textColor = model.cardExpiryColor
            self.lblExpiry.text = model.cardExpiry
            self.lblExpiry.font = model.cardExpiryFont
            self.lblExpiry.textColor = model.cardExpiryColor
            
            self.lblCVVTitle.text = Strings.Wallet.cvv
            self.lblCVVTitle.font = model.cardCVVFont
            self.lblCVVTitle.textColor = model.cardCVVColor
            self.lblCVV.text = model.cardCVV
            self.lblCVV.font = model.cardCVVFont
            self.lblCVV.textColor = model.cardCVVColor

            self.lblCardTitle.text = model.cardTitle
            self.lblCardTitle.font = model.cardTitleFont
            self.lblCardTitle.textColor = model.cardTitleColor
            self.btnCopyCardTitle.isHidden = !model.allowCopyCardTitle
            
            self.cardTypeImage.image = UIImage(named: model.cardTypeImage)
        }
    }
    @IBAction func didTapCopyCardno(_ sender:UIButton){
        UIPasteboard.general.string = /(self.cellModel as? CardCellModel)?.cardNo
        Alert.showToast(with: Strings.Wallet.copied_to_clipboard)
    }
    @IBAction func didTapCopyCardTitle(_ sender:UIButton){
        UIPasteboard.general.string = /(self.cellModel as? CardCellModel)?.cardTitle
        Alert.showToast(with: Strings.Wallet.copied_to_clipboard)
    }
}
final class CardCellModel:StandardCellModel {
    let cardBGImage:String
    let cardBrandImage:String
    
    let cardNo:String
    let cardNoFont:UIFont
    let cardNoColor:UIColor
    let allowCopyCardNo:Bool
    
    let cardExpiry:String
    let cardExpiryFont:UIFont
    let cardExpiryColor:UIColor
    
    let cardCVV:String
    let cardCVVFont:UIFont
    let cardCVVColor:UIColor
    
    let cardTitle:String
    let cardTitleFont:UIFont
    let cardTitleColor:UIColor
    let allowCopyCardTitle:Bool
    
    let cardTypeImage:String
    
    init(actions: StandardCellModel.ActionsType = nil,
         cardBGImage:String,
         cardBrandImage:String,
         cardNo:String,
         cardNoFont:UIFont = AppFont.appRegular(size: .body2),
         cardNoColor:UIColor = AppColor.azureishWhite,
         allowCopyCardNo:Bool = true,
         cardExpiry:String,
         cardExpiryFont:UIFont = AppFont.appRegular(size: .body2),
         cardExpiryColor:UIColor = AppColor.azureishWhite,
         cardCVV:String,
         cardCVVFont:UIFont = AppFont.appRegular(size: .body2),
         cardCVVColor:UIColor = AppColor.azureishWhite,
         cardTitle:String,
         cardTitleFont:UIFont = AppFont.appRegular(size: .body2),
         cardTitleColor:UIColor = AppColor.azureishWhite,
         allowCopyCardTitle:Bool = true,
         cardTypeImage:String)
    {
        self.cardBGImage = cardBGImage
        self.cardBrandImage = cardBrandImage
        self.cardNo = cardNo
        self.cardNoFont = cardNoFont
        self.cardNoColor = cardNoColor
        self.allowCopyCardNo = allowCopyCardNo
        self.cardExpiry = cardExpiry
        self.cardExpiryFont = cardExpiryFont
        self.cardExpiryColor = cardExpiryColor
        self.cardCVV = cardCVV
        self.cardCVVFont = cardCVVFont
        self.cardCVVColor = cardCVVColor
        self.cardTitle = cardTitle
        self.cardTitleFont = cardTitleFont
        self.cardTitleColor = cardTitleColor
        self.allowCopyCardTitle = allowCopyCardTitle
        self.cardTypeImage = cardTypeImage
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: CardCell.self)
    }
}
