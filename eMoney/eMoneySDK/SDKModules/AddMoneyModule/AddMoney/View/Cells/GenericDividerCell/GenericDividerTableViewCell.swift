//
//  GenericDividerTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//

import UIKit

final class GenericDividerTableViewCell: StandardCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configureCell() {
        super.configureCell()
        if let model = cellModel as? GenericDividerTableViewCellModel {
            heightConstraint.constant = model.dividerHeight
            dividerView.backgroundColor = model.dividerColor
            topConstraint.constant = model.topSpace
            leftConstraint.constant = model.leftSpace
            rightConstraint.constant = model.rightSpace
            bottomConstraint.constant = model.bottomSpace
            contentView.backgroundColor = model.backgroundColor
            layoutIfNeeded()
        }
    }
}

// MARK: - Class Model
final class GenericDividerTableViewCellModel: StandardCellModel {
    let topSpace: CGFloat
    let leftSpace: CGFloat
    let rightSpace: CGFloat
    let bottomSpace: CGFloat
    let dividerHeight: CGFloat
    let dividerColor: UIColor
    let backgroundColor: UIColor
    
    init(topSpace: CGFloat = 8,
         leftSpace: CGFloat = 24,
         rightSpace: CGFloat = 24,
         bottomSpace: CGFloat = 8,
         dividerHeight: CGFloat = 1,
         dividerColor: UIColor = AppColor.dividerColor,
         backgroundColor: UIColor = .clear) {
        self.topSpace = topSpace
        self.leftSpace = leftSpace
        self.rightSpace = rightSpace
        self.bottomSpace = bottomSpace
        self.dividerHeight = dividerHeight
        self.dividerColor = dividerColor
        self.backgroundColor = backgroundColor
        super.init(actions: nil)
    }
    
    override func reusableIdentifier() -> String {
        return GenericDividerTableViewCell.identifier()
    }
}
