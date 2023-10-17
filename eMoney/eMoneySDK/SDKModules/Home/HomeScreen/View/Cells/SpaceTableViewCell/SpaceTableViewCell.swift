//
//  SpaceTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 18/04/2023.
//

import UIKit

class SpaceTableViewCell: StandardCell {

    //MARK: - Outlets
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var viewParent: UIView!
    
    override func configureCell() {
        super.configureCell()
        if let model = cellModel as? SpaceTableViewCellModel {
            heightConstraint.constant = model.height
            viewParent.backgroundColor = model.backgroundColor
            backgroundColor = model.backgroundColor
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}


//MARK: - Cell Model -
final class SpaceTableViewCellModel: StandardCellModel {
    let height: CGFloat
    let backgroundColor: UIColor
    
    init(height: CGFloat, backgroundColor: UIColor = .clear) {
        self.height = height
        self.backgroundColor = backgroundColor
        super.init(actions: nil)
    }
    
    override func reusableIdentifier() -> String {
        return SpaceTableViewCell.identifier()
    }
}
