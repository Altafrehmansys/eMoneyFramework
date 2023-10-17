//
//  ChooseNameTableViewCell.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 13/07/2023.
//

import UIKit

class ChooseNameTableViewCell: StandardCell {

    @IBOutlet private weak var selectedImageIcon: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configureCell() {
        if let model = cellModel as? ChooseNameCellModel {
            self.selectedImageIcon.image =  model.selected ?  UIImage(named: "Radio-selected") : UIImage(named: "Right-content")
            self.nameLabel.text = model.name
        }
    }
    
}

final class ChooseNameCellModel: StandardCellModel {
    var selected: Bool
    let name: String
    init(actions: StandardCellModel.ActionsType = nil,
         selected: Bool,
         name: String) {
        self.selected = selected
        self.name = name
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ChooseNameTableViewCell.identifier()
    }
}

