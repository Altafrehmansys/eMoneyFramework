//
//  LabelWithLeftImageRightButton.swift
//  e&money
//
//  Created by Usama Zahid Khan on 12/07/2023.
//

import UIKit

class LabelWithLeftImageRightButtonCell: StandardCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var rightButton:UIButton!
    override func configureCell() {
        if let model = self.cellModel as? LabelWithLeftImageRightButtonCellModel {
            self.leftImageView.isHidden = model.leftImage == nil
            self.leftImageView.image = UIImage(named: /model.leftImage)
            self.titleLabel.text = model.title
            self.titleLabel.textColor = model.titleColor
            self.titleLabel.font = model.titleFont
            self.rightButton.isHidden = model.showRightButton
            self.rightButton.setTitle(model.buttonTitle, for: .normal)
            self.rightButton.titleLabel?.font = model.buttonFont
        }
    }
}
final class LabelWithLeftImageRightButtonCellModel:StandardCellModel {
    let backgroundColor: UIColor
    let leftImage:String?
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    let buttonTitle:String
    let buttonFont:UIFont
    let showRightButton:Bool
    init(actions:StandardCellActions? = nil,
         backgroundColor: UIColor = AppColor.eAnd_Success_10,
         leftImage:String = "info-circle-green",
         title: String,
         titleFont: UIFont,
         titleColor: UIColor,
         buttonTitle: String,
         buttonFont: UIFont,
         showRightButton:Bool = false) {
        self.backgroundColor = backgroundColor
        self.leftImage = leftImage
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.buttonTitle = buttonTitle
        self.buttonFont = buttonFont
        self.showRightButton = showRightButton
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: OrderPhysicalCardCell.self)
    }
}
