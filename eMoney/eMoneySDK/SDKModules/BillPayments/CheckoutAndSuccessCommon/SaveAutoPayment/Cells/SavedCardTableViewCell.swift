//
//  SavedCardTableViewCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 21/06/2023.
//

import UIKit

class SavedCardTableViewCell: StandardCell {
    @IBOutlet weak var btnRadio:UIButton!
    @IBOutlet weak var leftImage:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblSubtitle:UILabel!
    
    override func configureCell() {
        if let model = cellModel as? SavedCardTableViewCellModel {
            btnRadio.isHidden = model.isSelectionEnabled
            btnRadio.isSelected = model.isSelected
            
            leftImage.image = UIImage(named: model.leftImage ?? "")
            leftImage.layer.cornerRadius = model.isImageRounded ? leftImage.layer.cornerRadius / 2 : 0
            
            lblTitle.text = model.title
            lblTitle.textColor = model.titleColor
            lblTitle.font = model.titleFont
            
            lblSubtitle.text = model.subtitle
            lblSubtitle.textColor = model.subtitleColor
            lblSubtitle.font = model.subtitleFont
        }
    }
}
final class SavedCardTableViewCellModel:StandardCellModel {
    let isSelectionEnabled:Bool
    let isSelected:Bool
    
    let leftImage:String?
    let isImageRounded:Bool
    
    let title:String?
    let titleColor:UIColor?
    let titleFont:UIFont?
    
    let subtitle:String?
    let subtitleColor:UIColor?
    let subtitleFont:UIFont?
    init(actions: StandardCellModel.ActionsType = nil,
                  isSelectionEnabled:Bool = false,
                  isSelected:Bool = false,
                  leftImage:String?,
                  isImageRounded:Bool = true,
                  title:String?,
                  titleColor:UIColor? = AppColor.eAnd_Black_80,
                  titleFont:UIFont? = AppFont.appRegular(size: .body3),
                  subtitle:String?,
                  subtitleColor:UIColor? = AppColor.eAnd_Grey_100,
                  subtitleFont:UIFont? = AppFont.appRegular(size: .body4)) {
        self.isSelectionEnabled  = isSelectionEnabled
        self.isSelected = isSelected
        self.leftImage = leftImage
        self.isImageRounded = isImageRounded
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.subtitle = subtitle
        self.subtitleColor = subtitleColor
        self.subtitleFont = subtitleFont
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return String(describing: SavedCardTableViewCell.self)
    }
}
