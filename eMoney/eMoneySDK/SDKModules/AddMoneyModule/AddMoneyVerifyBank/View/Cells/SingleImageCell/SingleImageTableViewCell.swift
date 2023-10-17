//
//  SingleImageTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//

import UIKit

class SingleImageTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        
    }
    
    override func configureCell() {
        if let cell = cellModel as? SingleImageTableViewCellModel {
            
            self.cellImage.image = UIImage(named: cell.image)
            
            if let backgroundImage = cell.backgroundImage {
                self.backgroundImage.image = UIImage(named: backgroundImage)
            }
            
            layoutIfNeeded()
        }
    }
}

// MARK: - Cell Model
final class SingleImageTableViewCellModel: StandardCellModel {
    let image: String
    let backgroundImage: String?
    
    init(actions: StandardCellModel.ActionsType = nil, image: String, backgroundImage: String? = nil) {
        self.image = image
        self.backgroundImage = backgroundImage
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SingleImageTableViewCell.identifier()
    }
}
