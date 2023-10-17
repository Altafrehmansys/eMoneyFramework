//
//  DueBillsCollapsedTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 09/06/2023.
//

import UIKit

class DueBillsCollapsedTableViewCell: StandardCell {
    
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var imgViewThree: UIImageView!
    @IBOutlet weak var imgViewTwo: UIImageView!
    @IBOutlet weak var imgViewOne: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? DueBillsCollapsedTableViewCellModel {
            self.titleLabel.text = model.title
            self.subTitleLabel.text = model.subTitle
            self.imgViewOne.image = UIImage(named:model.imageOne)
            self.imgViewTwo.image = UIImage(named:model.imageTwo)
            self.imgViewThree.image = UIImage(named:model.imageThree)
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

class DueBillsCollapsedTableViewCellModel:StandardCellModel{
    
    let title: String
    let subTitle: String
    let imageOne: String
    let imageTwo:String
    let imageThree:String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         subTitle: String,
         imageOne: String,
         imageTwo:String,
         imageThree:String,methodType:MethodOptionsBaseTypes? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.imageOne = imageOne
        self.imageTwo = imageTwo
        self.imageThree = imageThree
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return DueBillsCollapsedTableViewCell.identifier()
    }
}
