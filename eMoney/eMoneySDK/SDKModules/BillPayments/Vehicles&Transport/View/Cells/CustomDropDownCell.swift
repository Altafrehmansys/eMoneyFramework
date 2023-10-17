//
//  DropDownCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 30/05/2023.
//

import UIKit
import DropDown

class CustomDropDownCell: DropDownCell {

    @IBOutlet weak var labelLeadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var separatorViewTrailingContraint: NSLayoutConstraint!
    @IBOutlet weak var separatorViewTLeadingConstraints: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    
    
    func setLabelLeadingConstraints(value: CGFloat) {
        labelLeadingConstraints.constant = value
        self.layoutIfNeeded()
    }
    
    func setLabelTralinlingConstraints(value: CGFloat) {
        labelTrailingContraint.constant = value
        self.layoutIfNeeded()
    }
    
    func setSeparatorLeadingConstraints(value: CGFloat) {
        separatorViewTLeadingConstraints.constant = value
        self.layoutIfNeeded()
    }
    
    func setSeparatorTralinlingConstraints(value: CGFloat) {
        separatorViewTrailingContraint.constant = value
        self.layoutIfNeeded()
    }
    
    func setLabelTextAlignment(alignment: NSTextAlignment) {
        optionLabel.textAlignment = alignment
    }
}
