//
//  DataNotFoundTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//

import UIKit

final class DataNotFoundTableViewCell: StandardCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setup()
    }
    
    override func configureCell() {
        if let model = cellModel as? DataNotFoundTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFontAndColor.0
            titleLabel.textColor = model.titleFontAndColor.1
            
            descriptionLabel.text = model.description
            descriptionLabel.font = model.descriptionFontAndColor.0
            descriptionLabel.textColor = model.descriptionFontAndColor.1
            
            statusImage.image = UIImage(named: model.image)
        }
    }
}

// MARK: - Class Methods
extension DataNotFoundTableViewCell {
    private func setup() {
        titleLabel.font = AppFont.appRegular(size: .body4)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        descriptionLabel.font = AppFont.appSemiBold(size: .body3)
        descriptionLabel.textColor = AppColor.eAnd_Black_80
    }
}

// MARK: - Cell Model
final class DataNotFoundTableViewCellModel: StandardCellModel {
    let title: String
    let titleFontAndColor: (UIFont, UIColor)
    let description: String
    let descriptionFontAndColor: (UIFont, UIColor)
    let image: String
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFontAndColor: (UIFont, UIColor) = (AppFont.appRegular(size: .body4), AppColor.eAnd_Black_80),
         description: String,
         descriptionFontAndColor: (UIFont, UIColor) = (AppFont.appSemiBold(size: .body3), AppColor.eAnd_Black_80),
         image: String) {
        self.title = title
        self.titleFontAndColor = titleFontAndColor
        self.description = description
        self.descriptionFontAndColor = descriptionFontAndColor
        self.image = image
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return DataNotFoundTableViewCell.identifier()
    }
}
