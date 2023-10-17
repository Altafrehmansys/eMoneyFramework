//
//  RegisterOptionCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit
import Kingfisher

class RegisterOptionCell: StandardCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        
        titleLabel.font = AppFont.appSemiBold(size: .body2)
        subtitleLabel.font = AppFont.appRegular(size: .body4)
        
        titleLabel.textColor = AppColor.eAnd_Black_80
        subtitleLabel.textColor = AppColor.eAnd_Grey_100
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
        containerView.cornerRadius = 16
        
        iconImageView.cornerRadius = iconImageView.frame.size.height / 2
        iconContainerView.cornerRadius = iconContainerView.frame.size.height / 2
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? RegisterOptionCellModel {
            titleLabel.text = model.title
            subtitleLabel.text = model.subtitle
            let url = URL(string: model.image)
            //self.iconImageView.kf.setImage(with: url)
        }
    }
}


// MARK: - Cell model
final class RegisterOptionCellModel: StandardCellModel {
    enum ActionsTypes:String {
        case emiratesId = "REG_EID"
        case uaePass = "REG_UAEPASS"
    }
    
    let title: String
    let subtitle: String
    let image: String
    let type: ActionsTypes
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, subtitle: String, image: String, type: String) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.type = ActionsTypes(rawValue: type) ?? .emiratesId
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return RegisterOptionCell.identifier()
    }
}
