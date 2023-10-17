//
//  SelectedBankTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//

import UIKit

final class SelectedBankTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var bankLogoImageView: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bankLogoImageView.cornerRadius = bankLogoImageView.frame.height / 2
        bankName.font = AppFont.appSemiBold(size: .body2)
        bankName.textColor = AppColor.eAnd_Black_80
    }
    
    override func configureCell() {
        if let model = cellModel as? SelectedBankTableViewCellModel {
            
            if let url = URL(string: model.logo) {
                bankLogoImageView.load(url: url)
            }
            bankName.text = model.name
        }
    }
}

// MARK: - Cell Model
final class SelectedBankTableViewCellModel: StandardCellModel {
    let logo: String
    let name: String
    
    init(actions: StandardCellModel.ActionsType = nil, logo: String, name: String) {
        self.logo = logo
        self.name = name
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SelectedBankTableViewCell.identifier()
    }
}
