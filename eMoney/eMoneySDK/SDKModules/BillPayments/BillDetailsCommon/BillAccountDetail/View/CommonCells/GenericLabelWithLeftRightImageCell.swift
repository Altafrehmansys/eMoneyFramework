//
//  GenericLabelWithLeftRightImageCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 05/07/2023.
//

import UIKit

class GenericLabelWithLeftRightImageCell: StandardCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var leftImageWConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftImageHConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var rightImageWConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightImageHConstraint: NSLayoutConstraint!
    
    override func configureCell() {
        
        if let model = cellModel as? GenericLabelWithLeftRightImageCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            
            if let image = model.leftImage {
                if let image = UIImage(named: image){
                    self.leftImage.image = image
                }else if let url = URL(string:image){
                    self.leftImage.load(url: url)
                }
            }else{
                self.leftImage.isHidden = true
            }
            if model.leftImageSize != .zero {
                leftImageWConstraint.constant = model.leftImageSize.width
                leftImageHConstraint.constant = model.leftImageSize.height
                self.layoutIfNeeded()
            }
            if let image = model.rightImage {
                if let image = UIImage(named: image){
                    self.rightImage.image = image
                }else if let url = URL(string:image){
                    self.rightImage.load(url: url)
                }
            }else{
                self.rightImage.isHidden = true
            }
            if model.rightImageSize != .zero {
                rightImageWConstraint.constant = model.rightImageSize.width
                rightImageHConstraint.constant = model.rightImageSize.height
                self.layoutIfNeeded()
            }
        }
    }
    
}

// MARK: - Cell Model
final class GenericLabelWithLeftRightImageCellModel: StandardCellModel {
  
    let leftImage: String?
    let leftImageSize:CGSize
    let title:String
    let titleFont:UIFont
    let titleColor:UIColor
    let methodType: MethodOptionsBaseTypes?
    let rightImage: String?
    let rightImageSize:CGSize
    init(actions: StandardCellModel.ActionsType = nil,
         methodType: MethodOptionsBaseTypes? = nil,
         leftImage: String?,
         leftImageSize:CGSize = .zero,
         title:String,
         titleFont:UIFont = AppFont.appRegular(size: .body3),
         titleColor:UIColor = AppColor.eAnd_Black_80,
         rightImage: String? = "arrow-right 1",
         rightImageSize:CGSize = .zero) {
        self.leftImage = leftImage
        self.leftImageSize = leftImageSize
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        self.methodType = methodType
        self.rightImage = rightImage
        self.rightImageSize = rightImageSize
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return GenericLabelWithLeftRightImageCell.identifier()
    }
}
