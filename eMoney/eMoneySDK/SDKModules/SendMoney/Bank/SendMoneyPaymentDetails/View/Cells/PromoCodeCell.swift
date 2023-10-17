//
//  PromoCodeCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/05/2023.
//


import UIKit

class PromoCodeCell: StandardCell {
    
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var leftImage:UIImageView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var promoLabel: UILabel!
    // MARK: - Override Methods
    override func configureCell() {
        if let model = cellModel as? PromoCodeCellModel {
            self.cellParentView.backgroundColor = model.parentColor
            self.leftImage.image = model.leftImage
            self.promoLabel.text = model.promoLabel
            self.promoLabel.font = model.promoLabelFont
            self.promoLabel.textColor = model.promoLabelTextColor
            self.cellParentView.layer.cornerRadius = 8
            if model.isPromoApplied {
                self.btnApply.setTitle(nil, for: .normal)
                self.btnApply.setImage(UIImage(named:"Close-icon"), for: .normal)
            }else{
                self.btnApply.setImage(nil, for: .normal)
                self.btnApply.setTitle(model.applyButtonText, for: .normal)
                self.btnApply.titleLabel?.font = model.applyButtonFont
            }
        }
    }
    @IBAction func didTapApply(_ sender:UIButton) {
        if let model = self.cellModel as? PromoCodeCellModel {
            cellModel?.actions?.cellSelected(0,model)
        }
    }
    
}

// MARK: - Cell Model
final class PromoCodeCellModel: StandardCellModel {
    let parentColor:UIColor
    let leftImage:UIImage?
    let promoLabel: String
    let promoLabelFont: UIFont
    let promoLabelTextColor: UIColor
    let isPromoApplied:Bool
    let applyButtonText:String
    let applyButtonFont:UIFont
    init(actions: StandardCellModel.ActionsType = nil,
         parentColor:UIColor = AppColor.eAnd_Best_seller,
         leftImage:UIImage? = UIImage(named: "tag-icon"),
         promoLabel: String,
         promoLabelFont: UIFont = AppFont.appRegular(size: .body4),
         promoLabelTextColor: UIColor = AppColor.eAnd_Maroon,
         isPromoApplied: Bool = false,
         applyButtonText:String = "Apply".localized,
         applyButtonFont:UIFont = AppFont.appMedium(size: .body4)) {
        self.parentColor = parentColor
        self.leftImage = leftImage
        self.promoLabel = promoLabel
        self.promoLabelFont = promoLabelFont
        self.promoLabelTextColor = promoLabelTextColor
        self.isPromoApplied = isPromoApplied
        self.applyButtonText = applyButtonText
        self.applyButtonFont = applyButtonFont
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return PromoCodeCell.identifier()
    }
}
