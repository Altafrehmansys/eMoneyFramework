//
//  SavedFundingMethodTableCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 22/06/2023.
//

import UIKit

class SavedFundingMethodTableCell: StandardCell {
    @IBOutlet weak var lblTItle:UILabel!
    @IBOutlet weak var lblSubtItle:UILabel!
    @IBOutlet weak var btnRight: UIButton!
    override func configureCell() {
        if let model = cellModel as? SavedFundingMethodTableCellModel {
            lblTItle.text = model.title
            lblTItle.textColor = model.titleColor
            lblTItle.font = model.titleFont
            lblSubtItle.text = model.subtitle
            lblSubtItle.textColor = model.subtitleColor
            lblSubtItle.font = model.subtitleFont
            self.btnRight.setImage(UIImage(named: model.rightImage), for: .normal)
        }
    }
    
}
final class SavedFundingMethodTableCellModel:StandardCellModel {
    let title:String?
    let titleColor:UIColor?
    let titleFont:UIFont?
    
    let subtitle:String?
    let subtitleColor:UIColor?
    let subtitleFont:UIFont?
    
    let rightImage:String
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String?,
         titleColor: UIColor? = AppColor.eAnd_Black_80,
         titleFont: UIFont? = AppFont.appSemiBold(size: .body2),
         subtitle: String?,
         subtitleColor: UIColor? = AppColor.eAnd_Black_80,
         subtitleFont: UIFont? = AppFont.appRegular(size: .body3),
         rightImage: String = "right-arrow") {
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.subtitle = subtitle
        self.subtitleColor = subtitleColor
        self.subtitleFont = subtitleFont
        self.rightImage = rightImage
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: SavedFundingMethodTableCell.self)
    }
}
