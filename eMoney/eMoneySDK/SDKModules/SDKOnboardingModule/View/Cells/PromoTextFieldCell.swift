//
//  PromoTextFieldCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 06/06/2023.
//

import UIKit

class PromoTextFieldCell: StandardCell {
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var tfPromo:UITextField!
    @IBOutlet weak var btnApply:UIButton!
    override func configureCell() {
        if let model = self.cellModel as? PromoTextFieldCellModel {
            self.bgView.cornerRadius = model.cellRadius ?? 0.0
            self.bgView.borderColor = model.borderColor
            self.bgView.borderWidth = 1
            self.tfPromo.text = model.promo
            self.tfPromo.textColor = model.promoColor
            self.tfPromo.font = model.promoFont
            
            self.btnApply.setTitle(model.buttonTitle, for: .normal)
            self.btnApply.borderColor = model.buttonTitleColor
            self.btnApply.borderWidth = 1
            self.btnApply.setTitleColor(model.buttonTitleColor, for: .normal) 
            self.btnApply.titleLabel?.font = model.buttonTitleFont
        }
    }
    @IBAction func didTapApply(_ sender: UIButton) {
        if let model = cellModel as? PromoTextFieldCellModel{
            model.promo = self.tfPromo.text
            cellModel?.actions?.cellSelected(0,model)
        }
    }
}
final class PromoTextFieldCellModel:StandardCellModel {
    let cellRadius:CGFloat?
    let borderColor:UIColor!
    
    var promo:String?
    let promoFont:UIFont?
    let promoColor:UIColor
    
    let buttonTitle:String?
    let buttonTitleFont:UIFont?
    let buttonTitleColor:UIColor?
    
    init(actions: StandardCellModel.ActionsType = nil,
         cellRadius:CGFloat = 16,
         borderColor:UIColor? = AppColor.eAnd_Grey_50,
         promo: String? = nil,
         promoFont: UIFont? = AppFont.appRegular(size: .body2),
         promoColor: UIColor = AppColor.eAnd_Black_80,
         buttonTitle: String? = "Apply".localized,
         buttonTitleFont: UIFont? = AppFont.appRegular(size: .body2),
         buttonTitleColor: UIColor? = AppColor.eAnd_Grey_70) {
        self.cellRadius = cellRadius
        self.borderColor = borderColor
        self.promo = promo
        self.promoFont = promoFont
        self.promoColor = promoColor
        self.buttonTitle = buttonTitle
        self.buttonTitleFont = buttonTitleFont
        self.buttonTitleColor = buttonTitleColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return String(describing: PromoTextFieldCell.self)
    }
}
