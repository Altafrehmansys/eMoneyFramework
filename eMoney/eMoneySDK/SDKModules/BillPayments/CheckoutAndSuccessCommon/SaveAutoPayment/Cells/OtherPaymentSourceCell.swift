//
//  GenericLabelWithLeftRightImageCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 21/06/2023.
//

import UIKit

class OtherPaymentSourceCell: StandardCell {
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var btnRight:UIButton!
    
    override func configureCell() {
        if let model = cellModel as? OtherPaymentSourceCellModel {
            leftImage.image = UIImage(named: model.leftImage ?? "")
            lblTitle.text = model.title
            lblTitle.textColor = model.titleColor
            lblTitle.font = model.titleFont
            btnRight.setImage(UIImage(named: model.rightImage ?? ""), for: .normal)
        }
    }
}
final class OtherPaymentSourceCellModel:StandardCellModel {
    let leftImage:String?
    
    let title:String?
    let titleColor:UIColor
    let titleFont:UIFont
    let titleAlignment:NSTextAlignment
    
    let rightImage:String?
    let methodType:OtherPaymentSource?
    init(actions: StandardCellModel.ActionsType = nil,
                  leftImage:String,
                  title:String,
                  titleColor:UIColor = AppColor.eAnd_Black_80,
                  titleFont:UIFont = AppFont.appRegular(size: .body3),
                  titleAlignment:NSTextAlignment = .left,
                  rightImage:String,
                  methodType:OtherPaymentSource = .card) {
        self.leftImage = leftImage
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.titleAlignment = titleAlignment
        self.rightImage = rightImage
        self.methodType = methodType
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        String(describing: OtherPaymentSourceCell.self)
    }
}
