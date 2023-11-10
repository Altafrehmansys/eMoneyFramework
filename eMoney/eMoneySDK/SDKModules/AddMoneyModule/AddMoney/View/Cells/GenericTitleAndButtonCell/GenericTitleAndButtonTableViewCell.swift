//
//  GenericTitleAndButtonTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 26/04/2023.
//

import UIKit

final class GenericTitleAndButtonTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trailingButton: BaseButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func configureCell() {
        if let model = cellModel as? GenericTitleAndButtonTableViewCellModel {
            
            titleLabel.text = model.title
            titleLabel.font = model.titleFontAndColor.0
            titleLabel.textColor = model.titleFontAndColor.1
            
            trailingButton.setTitle(model.buttonTitle, for: .normal)
            trailingButton.titleLabel?.font = AppFont.appMedium(size: .body4)
        }
    }
}

// MARK: - Class Methods
extension GenericTitleAndButtonTableViewCell {
    private func setup() {
        trailingButton.type = .PlainButton
        trailingButton.titleLabel?.textColor = AppColor.eAnd_Red_100
        trailingButton.addTarget(self, action: #selector(trailingButtonTappedAction(_:)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension GenericTitleAndButtonTableViewCell {
    @objc func trailingButtonTappedAction(_ sender: BaseButton) {
        if let cellModel {
            cellModel.actions?.cellSelected(0, cellModel)
        }
    }
}

// MARK: - Cell model
final class GenericTitleAndButtonTableViewCellModel: StandardCellModel {
    let title: String
    let titleFontAndColor: (UIFont, UIColor)
    let buttonTitle: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFontAndColor: (UIFont, UIColor) = (AppFont.appSemiBold(size: .body3), AppColor.eAnd_Black_80),
         buttonTitle: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.titleFontAndColor = titleFontAndColor
        self.buttonTitle = buttonTitle
        self.methodType = methodType
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return GenericTitleAndButtonTableViewCell.identifier()
    }
}
