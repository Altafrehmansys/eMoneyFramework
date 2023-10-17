//
//  ImageWithBottomLabel.swift
//  e&money
//
//  Created by Usama Zahid Khan on 11/07/2023.
//

import UIKit

class ImageWithBottomLabelCell: StandardCollectionViewCell {
    @IBOutlet weak var topImage:UIImageView!
    @IBOutlet weak var bottomLabel:UILabel!
    
    override func configureCell() {
        if let model = self.cellModel as? ImageWithBottomLabelCellModel {
            topImage.image = UIImage(named: model.image)
            bottomLabel.text = model.title
        }
    }
}
final class ImageWithBottomLabelCellModel:StandardCellModel {
    let image:String
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    
    init(cellAction: StandardCellActions? = nil,
         image:String,
         title:String,
         titleFont:UIFont =  AppFont.appRegular(size: .body5),
         titleColor:UIColor = AppColor.eAnd_Black_80){
        self.image = image
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.title = title
        super.init(actions:cellAction)
    }
    override func reusableIdentifier() -> String {
        String(describing: ImageWithBottomLabelCell.self)
    }
}
