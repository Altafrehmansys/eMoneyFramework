//
//  ExpandedBillsTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//

import UIKit

class ExpandedBillsTableViewCell: StandardCell {
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var cellParentView: UIView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? ExpandedBillsTableViewCellModel {
            self.titleLabel.text = model.title
            self.subTitleLabel.text = model.subTitle
            self.imgView.image = UIImage(named: model.image)
            
        }
    }
    func setUpUI() {
        titleLabel.font = AppFont.appRegular(size: .body3)
        titleLabel.textColor = AppColor.eAnd_Black_80
        subTitleLabel.font = AppFont.appRegular(size: .body4)
        subTitleLabel.textColor = AppColor.eAnd_Grey_100
        cellParentView.backgroundColor = AppColor.eAnd_Grey_10
        
    }
    
}

class ExpandedBillsTableViewCellModel:StandardCellModel{
    
    let title: String
    let subTitle: String
    let image:String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         subTitle: String,
         methodType:MethodOptionsBaseTypes? = nil,
         image:String) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ExpandedBillsTableViewCell.identifier()
    }
}
