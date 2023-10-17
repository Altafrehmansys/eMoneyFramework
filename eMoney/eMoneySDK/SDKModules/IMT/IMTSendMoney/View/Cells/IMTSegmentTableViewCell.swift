//
//  IMTSegmentTableViewCell.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 01/06/2023.
//

import UIKit

import UIKit

class IMTSegmentTableViewCell: StandardCell {

    @IBOutlet weak var segmentControl: BetterSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpSegment()
    }
    
    func setUpSegment(){
        segmentControl.announcesValueImmediately = false
        segmentControl.animationSpringDamping = 1.0
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? IMTSegmentCellModel {
            if model.segmentType == .iconWithLabel {
                guard let segmentData = model.iconWithTitles else { return }
                segmentControl.segments = IconWithLabelSegment.segments(withIconsAndLabels: segmentData,
                                                                        iconSize: CGSize(width: 16, height: 16),
                                                                        normalIconTintColor: .black,
                                                                        normalFont: AppFont.appRegular(size: .body4),
                                                                        normalTextColor: AppColor.eAnd_Black_80,
                                                                        selectedIconTintColor: .black,
                                                                        selectedFont: AppFont.appMedium(size: .body4),
                                                                        selectedTextColor: AppColor.eAnd_Black_80)
            }else{
                guard let segmentData = model.titles else { return }
                segmentControl.segments = LabelSegment.segments(withTitles: segmentData,
                                                                        normalFont: AppFont.appRegular(size: .body4),
                                                                        normalTextColor: AppColor.eAnd_Black_80,
                                                                        selectedFont: AppFont.appMedium(size: .body4),
                                                                        selectedTextColor: AppColor.eAnd_Black_80)
            }
            //segmentControl.setIndex(model.selectedIndex, animated: false, shouldSendValueChangedEvent: false)
        }
    }
    
    // MARK: - Action handlers
    @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        print("The selected index is \(sender.index)")
        if let cellModel {
            cellModel.actions?.cellSelected(sender.index, cellModel)
        }
        
    }
    
}
// MARK: - Cell model
final class IMTSegmentCellModel: StandardCellModel {
    enum SegmentType:String {
        case label
        case iconWithLabel
    }
    
    let titles: [String]?
    let iconWithTitles: [IconWithLabel]?
    let selectedIndex:Int
    let segmentType:SegmentType
    
    init(actions: StandardCellModel.ActionsType = nil, title: [String]? = nil, iconWithTitles: [IconWithLabel]? = nil, type: SegmentType,selectedIndex:Int) {
        self.titles = title
        self.iconWithTitles = iconWithTitles
        self.selectedIndex = selectedIndex
        self.segmentType = type
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return IMTSegmentTableViewCell.identifier()
    }
}
