//
//  ImageAndTitleCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 18/05/2023.
//

import UIKit
import Kingfisher
class ImageAndTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = AppFont.appRegular(size: .body5)
        titleLabel.textColor = AppColor.eAnd_Black_80
        imgView.cornerRadius = imgView.frame.width / 2
    }
    
    func configureCell(with dataModel: ListItems) {
        self.titleLabel.text = dataModel.title
        let url = URL(string: dataModel.imageUrl ?? "")
        self.imgView.kf.setImage(with: url)
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
}


