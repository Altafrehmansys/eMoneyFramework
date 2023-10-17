//
//  CollapsableTitleTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//

import UIKit

class CollapsableTitleTableViewCell: StandardCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func configureCell() {
        if let model = cellModel as? CollapsableTitleTableViewCellModel {
            titleLabel.text = model.title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleTextColor
            
            let image = model.isCollapsed ? "arrow-down" : "arrow-up"
            chevronImageView.image = UIImage(named: image)
            
            topConstraint.constant = model.topSpace
        }
    }
}

// MARK: - Cell Model
final class CollapsableTitleTableViewCellModel: StandardCellModel {
    let title: String
    let titleFont: UIFont
    let titleTextColor: UIColor
    let isCollapsed: Bool
    let topSpace: CGFloat
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleFont: UIFont = AppFont.appSemiBold(size: .body2),
         titleTextColor: UIColor = AppColor.eAnd_Black_80,
         isCollapsed: Bool,
         topSpace: CGFloat = 8) {
        self.title = title
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
        self.isCollapsed = isCollapsed
        self.topSpace = topSpace
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return CollapsableTitleTableViewCell.identifier()
    }
}
