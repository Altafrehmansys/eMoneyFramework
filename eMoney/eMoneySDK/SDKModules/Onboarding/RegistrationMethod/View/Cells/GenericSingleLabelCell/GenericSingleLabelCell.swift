//
//  GenericSingleLabelCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class GenericSingleLabelCell: StandardCell {
    // MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? GenericSingleLabelCellModel {
            
            if let attributedContent = model.attributedContent {
                label.attributedText = attributedContent
            } else {
                label.text = model.content
                label.font = model.font
                label.textColor = model.color
                label.textAlignment = model.alignment
            }
            
            topConstraint.constant = model.topSpace
            leftConstraint.constant = model.leftSpace
            rightConstraint.constant = model.rightSpace
            bottomConstraint.constant = model.bottomSpace
            layoutIfNeeded()
        }
    }
}

// MARK: - Cell model
final class GenericSingleLabelCellModel: StandardCellModel {
    let content: String
    let attributedContent: NSAttributedString?
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment
    let topSpace: CGFloat
    let leftSpace: CGFloat
    let rightSpace: CGFloat
    let bottomSpace: CGFloat
    
    /// Have some predefined properties, e.g.
    /// Font, It has predefined value as `AppFont.appRegular(size: .body2)`
    /// Color, It has predefined value as `AppColor.eAnd_Black_80`
    /// Top space, predefined value as `12`
    /// Left space, predefined value as `24`
    /// Right space, predefined value as `24`
    /// Bottom space, predefined value as `8`
    init(actions: StandardCellModel.ActionsType = nil,
         content: String,
         attributedContent: NSAttributedString? = nil,
         font: UIFont = AppFont.appRegular(size: .body2),
         color: UIColor = AppColor.eAnd_Black_80,
         alignment: NSTextAlignment = .left,
         topSpace: CGFloat = 12,
         leftSpace: CGFloat = 24,
         rightSpace: CGFloat = 24,
         bottomSpace: CGFloat = 8) {
        self.content = content
        self.attributedContent = attributedContent
        self.font = font
        self.color = color
        self.alignment = alignment
        self.topSpace = topSpace
        self.leftSpace = leftSpace
        self.rightSpace = rightSpace
        self.bottomSpace = bottomSpace
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return GenericSingleLabelCell.identifier()
    }
}
