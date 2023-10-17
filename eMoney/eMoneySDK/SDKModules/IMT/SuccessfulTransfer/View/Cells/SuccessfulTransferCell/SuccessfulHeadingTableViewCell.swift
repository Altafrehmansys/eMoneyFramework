//
//  SuccessfulHeadingTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 09/06/2023.
//

import UIKit

class SuccessfulHeadingTableViewCell: StandardCell {

    @IBOutlet weak var labelTransfer: UILabel!
    @IBOutlet weak var imageViewTransfer: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? SuccessfulHeadingTableViewCellModel {
            labelTransfer.text = model.heading
            imageViewTransfer.image = UIImage(named: model.image)
           
        }
    }
    
}
// MARK: - Cell model

final class SuccessfulHeadingTableViewCellModel: StandardCellModel {

    let image: String
    let heading: String
   
    init(actions: StandardCellModel.ActionsType = nil, image: String, heading: String) {
        self.image = image
        self.heading = heading
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SuccessfulHeadingTableViewCell.identifier()
    }
}
