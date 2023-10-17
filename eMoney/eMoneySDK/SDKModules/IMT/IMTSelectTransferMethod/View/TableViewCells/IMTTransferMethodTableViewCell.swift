//
//  IMTTransferMethodTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 30/05/2023.
//

import UIKit

class IMTTransferMethodTableViewCell: StandardCell {
    
    @IBOutlet var lblMethodName: UILabel!
    @IBOutlet var lblConversionRate: UILabel!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI() {
        
        lblMethodName.font = AppFont.appRegular(size: .body3)
        lblMethodName.textColor = AppColor.eAnd_Black_80
        
        lblConversionRate.font = AppFont.appMedium(size: .body4)
        lblConversionRate.textColor = AppColor.eAnd_Black_80
        
        lblDuration.font = AppFont.appRegular(size: .body4)
        lblDuration.textColor = AppColor.eAnd_Black_80
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        containerView.cornerRadius = 12
        
        iconImageView.cornerRadius = iconImageView.frame.size.height / 2
        iconContainerView.cornerRadius = iconContainerView.frame.size.height / 2
    }
    
    // MARK: - Update UI
    override func configureCell() {
//        if let model = cellModel as? RegisterOptionCellModel {
//            titleLabel.text = model.title
//            subtitleLabel.text = model.subtitle
//            let url = URL(string: model.image)
//            self.iconImageView.kf.setImage(with: url)
//        }
    }
}
// MARK: - Cell model
final class IMTTransferMethodCellModel: StandardCellModel {
    let title: String
    let subtitle: String
    let image: String
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, subtitle: String, image: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return IMTTransferMethodTableViewCell.identifier()
    }
}
