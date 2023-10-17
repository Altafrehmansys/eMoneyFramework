//
//  TopUpSegmentCell.swift
//  e&money
//
//  Created by Usama Zahid Khan on 29/05/2023.
//

import UIKit

class TopUpSegmentCell: StandardCell {
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var segmentControl:FloatingSegmentedControl!
    override func configureCell() {
        if let model = self.cellModel as? TopUpSegmentCellModel {
            self.lblTitle.text = model.title
            self.lblTitle.textColor = model.titleColor
            self.lblTitle.font = model.titleFont
            self.configureSegmentControl()
        }
    }
    func configureSegmentControl() {
        segmentControl.setSegments(with: ["Airtime", "Bundles"])
        segmentControl.addTarget(self, action: #selector(update(_:)))
        segmentControl.isAnimateFocusMoving = true
        segmentControl.focusedIndex = 0
    }
    @objc func update(_ sender: FloatingSegmentedControl) {
        if let cellModel = cellModel {
            cellModel.actions?.cellSelected(sender.focusedIndex, cellModel)
        }
        
    }
    
}
final class TopUpSegmentCellModel:StandardCellModel {
    let title:String
    let titleFont:UIFont!
    let titleColor:UIColor?
    init(actions: StandardCellActions? = nil,
                  title:String,
                  titleFont:UIFont = AppFont.appMedium(size: .body3),
                  titleColor:UIColor = AppColor.eAnd_Grey_100) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
        super.init(actions: actions)
    }
    override func reusableIdentifier() -> String {
        return TopUpSegmentCell.identifier()
    }
}
