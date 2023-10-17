//
//  CaptureIdentityTipsTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/04/2023.
//

import UIKit

class CaptureIdentityTipsTableViewCell: StandardCell {
    // MARK: - Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.font = AppFont.appRegular(size: .body4)
        labelTitle.textColor = AppColor.eAnd_Grey_100
        labelTitle.numberOfLines = 2
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? CaptureIdentityTipsCellModel {
            labelTitle.text = model.title.localized
            imgView.image = UIImage(named: model.imgName)
        }
    }
}

// MARK: - Cell model
final class CaptureIdentityTipsCellModel: StandardCellModel {
    let title: String
    let imgName: String
    
    init(title: String,imgName:String) {
        self.title = title
        self.imgName = imgName
        super.init()
    }

    override func reusableIdentifier() -> String {
        return CaptureIdentityTipsTableViewCell.identifier()
    }
}
