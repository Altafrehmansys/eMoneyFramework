//
//  RecentTransferCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 13/04/2023.
//

import UIKit

class RecentTransferCollectionViewCell: StandardCollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }

    private func setupUI() {
        nameLabel.font = AppFont.appRegular(size: .body3)
        nameLabel.textColor = AppColor.eAnd_Black_80
        
        amountLabel.font = AppFont.appRegular(size: .body4)
        amountLabel.textColor = AppColor.eAnd_Grey_70
        
        containerView.addShadow(shadowOpacity: 1,
                                shadowRadius: 4,
                                shadowOffset: CGSize(width: 0, height: 4),
                                shadowColor: AppColor.eAnd_Shadow)
        containerView.setProperties(cornerRadius: 12, borderColor: AppColor.eAnd_Grey_20, borderWidth: 1)
    }
    
    override func configureCell() {
        if let model = cellModel as? RecentTransferCollectionViewCellModel {
            nameLabel.text = model.name
            amountLabel.text = model.amount
            userImageView.image = UIImage(named: model.userImage)
            countryFlagImageView.image = UIImage(named: model.countryFlagImage)
        }
    }
}

// MARK: - Cell Model
final class RecentTransferCollectionViewCellModel: StandardCellModel {
    let name: String
    let amount: String
    let userImage: String
    let countryFlagImage: String
    
    init(actions: StandardCellModel.ActionsType = nil,
         name: String,
         amount: String,
         userImage: String,
         countryFlagImage: String)
    {
        self.name = name
        self.amount = amount
        self.userImage = userImage
        self.countryFlagImage = countryFlagImage
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return RecentTransferCollectionViewCell.identifier()
    }
}
