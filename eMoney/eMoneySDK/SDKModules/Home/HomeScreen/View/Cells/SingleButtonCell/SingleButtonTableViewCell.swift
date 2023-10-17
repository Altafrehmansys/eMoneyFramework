//
//  SingleButtonTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 18/04/2023.
//

import UIKit

final class SingleButtonTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var button: BaseButton!
    @IBOutlet weak var leftContraint:NSLayoutConstraint!
    @IBOutlet weak var rightContraint:NSLayoutConstraint!
    // MARK: - Configure Cell
    override func configureCell() {
        if let model = cellModel as? SingleButtonTableViewCellModel {
            button.type = model.type
            button.height = model.height
            button.setTitle(model.title, for: .normal)
            button.titleLabel?.font = model.font
            if let leftSpace = model.leftSpace {
                leftContraint.constant = leftSpace
            }else if self.leftContraint != nil {
                leftContraint.isActive = false
            }
            if let rightSpace = model.rightSpace {
                rightContraint.constant = rightSpace
            }else if rightContraint != nil{
                rightContraint.isActive = false
            }
            self.layoutIfNeeded()
        }
    }
}

// MARK: - IBActions
extension SingleButtonTableViewCell {
    @IBAction func buttonTappedAction(_ sender: UIButton) {
        guard let model = cellModel else { return }
        model.actions?.cellSelected(0, model)
    }
}


// MARK: - Cell model
final class SingleButtonTableViewCellModel: StandardCellModel {
    let title: String
    let type: BaseButtonType
    let height: Int
    let font: UIFont
    let leftSpace:CGFloat?
    let rightSpace:CGFloat?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         height: Int = 28,
         type: BaseButtonType,
         font: UIFont = AppFont.appMedium(size: .body4),
         leftSpace:CGFloat? = nil,
         rightSpace:CGFloat? = nil) {
        self.title = title
        self.height = height
        self.type = type
        self.font = font
        self.leftSpace = leftSpace
        self.rightSpace = rightSpace
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SingleButtonTableViewCell.identifier()
    }
}
