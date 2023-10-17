//
//  TitleImageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 15/05/2023.
//

import UIKit

final class TitleImageTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        if let model = cellModel as? TitleImageTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            
            titleImage.image = UIImage(named: model.titleImage)
        }
    }
}

final class TitleImageTableViewCellModel: StandardCellModel {
    
    let titleImage: String
    let title: String
    let titleFont: UIFont
    let titleColor: UIColor
    
    init(actions: StandardCellModel.ActionsType = nil,
         titleImage: String,
         title: String,
         titleFont: UIFont,
         titleColor: UIColor) {
        self.titleImage = titleImage
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return TitleImageTableViewCell.identifier
    }
}
