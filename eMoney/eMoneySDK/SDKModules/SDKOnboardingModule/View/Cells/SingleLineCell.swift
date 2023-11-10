//
//  SingleLineCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 02/06/2023.
//

import UIKit

class SingleLineCell: StandardCell {
    @IBOutlet weak var line:UIView!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    @IBOutlet weak var topContraint:NSLayoutConstraint!
    @IBOutlet weak var leftContraint:NSLayoutConstraint!
    @IBOutlet weak var rightContraint:NSLayoutConstraint!
    @IBOutlet weak var bottomContraint:NSLayoutConstraint!
    override func configureCell() {
        if let model = cellModel as? SingleLineCellModel {
            self.topContraint.constant = model.topSpeace
            self.leftContraint.constant = model.leftSpace
            self.rightContraint.constant = model.rightSpace
            self.bottomContraint.constant = model.bottomSpace
            self.heightContraint.constant = model.lineHeight
            self.line.backgroundColor = model.lineColor
            self.layoutIfNeeded()
        }
    }
}
final class SingleLineCellModel:StandardCellModel {
    let lineColor:UIColor
    let lineHeight:CGFloat
    let leftSpace:CGFloat
    let rightSpace:CGFloat
    let topSpeace:CGFloat
    let bottomSpace:CGFloat
    
    init(lineColor: UIColor = AppColor.eAnd_Grey_30,
         lineHeight: CGFloat = 0.5,
         leftSpace: CGFloat = 0,
         rightSpace: CGFloat = 0,
         topSpeace: CGFloat = 0,
         bottomSpace: CGFloat = 0) {
        self.lineColor = lineColor
        self.lineHeight = lineHeight
        self.leftSpace = leftSpace
        self.rightSpace = rightSpace
        self.topSpeace = topSpeace
        self.bottomSpace = bottomSpace
    }
    override func reusableIdentifier() -> String {
        return SingleLineCell.identifier
    }
}
