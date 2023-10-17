//
//  PlateViewTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 28/07/2023.
//

import UIKit

class PlateViewTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var plateCodeLabel: UILabel!
    @IBOutlet weak var plateNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plateCodeLabel.font = AppFont.appSemiBold(size: .h1)
        plateNumberLabel.font = AppFont.appSemiBold(size: .h1)
    }
    
    override func layoutSubviews() {
        
    }
    
    override func configureCell() {
        if let cell = cellModel as? PlateViewTableViewCellModel {
            
            self.cellImage.image = UIImage(named: cell.image)
            self.plateCodeLabel.text = cell.plateCode
            self.plateNumberLabel.text = cell.plateNumber
            if let backgroundImage = cell.backgroundImage {
                self.backgroundImage.image = UIImage(named: backgroundImage)
            }
            
            layoutIfNeeded()
        }
    }
}

// MARK: - Cell Model
final class PlateViewTableViewCellModel: StandardCellModel {
    let image: String
    let plateCode: String
    let plateNumber: String
    let backgroundImage: String?
    
    init(actions: StandardCellModel.ActionsType = nil, image: String, backgroundImage: String? = nil, plateCode: String, plateNumber: String) {
        self.image = image
        self.backgroundImage = backgroundImage
        self.plateCode = plateCode
        self.plateNumber = plateNumber
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return PlateViewTableViewCell.identifier()
    }
}
