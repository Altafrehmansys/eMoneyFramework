//
//  PromoCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 06/06/2023.
//

import UIKit

class PromoCell: StandardCell {
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var leftIconImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var subtitleLabel:UILabel!
    override func configureCell() {
        if let model = cellModel as? PromoCellModel {
            self.bgView.backgroundColor = model.backgroundColor
            self.bgView.layer.cornerRadius = model.cellCornerRadius ?? 20.0
            self.leftIconImageView.image = model.leftImage
            self.titleLabel.text = model.title
            self.titleLabel.font = model.titleFont
            self.titleLabel.textColor = model.titleColor
            self.subtitleLabel.text = model.subTitle
            self.subtitleLabel.font = model.subTitleFont
            self.subtitleLabel.textColor = model.subTitleColor
        }
    }
}
final class PromoCellModel: StandardCellModel {
    let backgroundColor:UIColor?
    let cellCornerRadius:CGFloat?
    
    let leftImage:UIImage?
    
    let title:String?
    let titleFont:UIFont?
    let titleColor:UIColor?
    
    let subTitle:String?
    let subTitleFont:UIFont?
    let subTitleColor:UIColor?
    init(actions: StandardCellModel.ActionsType = nil,
                  backgroundColor:UIColor?,
                  cellCornerRadius:CGFloat? = 20.0,
                  leftImage:UIImage? = UIImage(named: "promo-tag"),
                  title:String?,
                  titleFont:UIFont? = AppFont.appSemiBold(size: .body2),
                  titleColor:UIColor? = AppColor.eAnd_Black_80,
                  subTitle:String?,
                  subTitleFont:UIFont? = AppFont.appRegular(size: .body4),
                  subTitleColor:UIColor? = AppColor.eAnd_Grey_100) {
        self.backgroundColor = backgroundColor
        self.cellCornerRadius = cellCornerRadius
        self.leftImage = leftImage
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleFont = subTitleFont
        self.subTitleColor = subTitleColor
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        String(describing: PromoCell.self)
    }
}

