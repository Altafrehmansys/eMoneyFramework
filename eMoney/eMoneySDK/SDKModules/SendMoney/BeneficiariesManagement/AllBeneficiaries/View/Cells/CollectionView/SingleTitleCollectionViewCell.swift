//
//  SingleTitleCollectionViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//

import UIKit

class SingleTitleCollectionViewCell: StandardCollectionViewCell {
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = AppFont.appMedium(size: .body4)
        titleLabel.textColor = AppColor.eAnd_Black_80
    
      
       // cellParentView.addGradient(colors:[AppColor.eAnd_Red_100,AppColor.eAnd_Grey_100], locations: [0, 1], startPoint: CGPoint(x: 0.25, y: 0.5), endPoint:  CGPoint(x: 0.75, y: 0.5))
        cellParentView.layer.cornerRadius = 16
       

    }
    override func configureCell() {
        if let model = cellModel as? SingleTitleCollectionViewCellModel {
            titleLabel.text = model.title
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }

    override var isSelected: Bool {
        didSet {
            cellParentView.backgroundColor = isSelected ? AppColor.linearGradientEnd  : .clear
        }
    }
}

// MARK: - ServiceCollectionViewCellModel
final class SingleTitleCollectionViewCellModel: StandardCellModel {
    let title: String
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String, methodType: MethodOptionsBaseTypes? = nil)
    {
        self.title = title
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SingleTitleCollectionViewCell.identifier()
    }
}
