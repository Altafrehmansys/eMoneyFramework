//
//  ImageWithBelowTitleTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 13/06/2023.
//

import UIKit

class ImageWithBelowTitleTableViewCell: StandardCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? ImageWithBelowTitleTableViewCellModel {
            self.titleLabel.text = model.title
            self.imgView.image = UIImage(named: model.imgName)
        }
    }
    func setUpUI() {
        self.titleLabel.font = AppFont.appRegular(size: .body5)
        self.titleLabel.textColor = AppColor.eAnd_Black_80
    }
    
}
// MARK: - Cell Model
final class ImageWithBelowTitleTableViewCellModel: StandardCellModel {
    
    let title: String
    let imgName:String
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         imgName:String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.imgName = imgName
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ImageWithBelowTitleTableViewCell.identifier()
    }
}

