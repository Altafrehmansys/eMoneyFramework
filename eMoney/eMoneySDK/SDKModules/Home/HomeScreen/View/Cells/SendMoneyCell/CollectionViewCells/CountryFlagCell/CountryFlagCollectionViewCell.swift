//
//  CountryFlagCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 13/04/2023.
//

import UIKit
import Kingfisher

final class CountryFlagCollectionViewCell: StandardCollectionViewCell {
    
    // MARK: - IBOutelets
    @IBOutlet weak var flageImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        flageImageView.cornerRadius = flageImageView.frame.size.height / 2
    }
    
    override func configureCell() {
        if let model = cellModel as? CountryFlagCollectionViewCellModel {
            flageImageView.image = UIImage(named: model.flagImage)
        }
    }
}

final class CountryFlagCollectionViewCellModel: StandardCellModel {
    let flagImage: String
    
    init(actions: StandardCellModel.ActionsType = nil, flagImage: String) {
        self.flagImage = flagImage
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return CountryFlagCollectionViewCell.identifier()
    }
}
