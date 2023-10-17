//
//  LabelWithLeftIconCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//

import UIKit

class LabelWithLeftIconCell: StandardCell {
    @IBOutlet weak var bgView:UIView!
    @IBOutlet weak var leftIconImageView:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    override func configureCell() {
        if let model = cellModel as? LabelWithLeftIconCellModel {
            self.bgView.backgroundColor = model.viewColor
            self.bgView.layer.cornerRadius = model.viewCornerRaduis
            self.leftIconImageView.image = model.leftImage
            self.lblTitle.text = model.title
            self.lblTitle.textColor = model.titleColor
            self.lblTitle.font = model.titleFont
            self.leftIconImageView.isHidden = model.leftImage == nil
        }
    }
}
final class LabelWithLeftIconCellModel:StandardCellModel {
    let viewColor:UIColor
    let viewCornerRaduis:CGFloat
    
    let leftImage:UIImage?
    
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    
    init(cellAction: StandardCellModel.ActionsType = nil,
        viewColor:UIColor = .white,
        viewCornerRaduis:CGFloat = 12.0,
        leftImage:UIImage? = nil,
        title:String,
        titleFont:UIFont = AppFont.appMedium(size: .body4),
        titleColor:UIColor = AppColor.eAnd_Black_80) {
        self.viewColor = viewColor
        self.viewCornerRaduis = viewCornerRaduis
        self.leftImage = leftImage
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
    }
    override func reusableIdentifier() -> String {
        return String(describing:LabelWithLeftIconCell.self)
    }
    
}
