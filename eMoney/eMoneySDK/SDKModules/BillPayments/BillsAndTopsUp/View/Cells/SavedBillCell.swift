//
//  SavedBillCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 06/06/2023.
//

import UIKit
import Kingfisher

class SavedBillCell: StandardCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SavedBillCellModel {
            self.titleLabel.text = model.title
            if let image = UIImage(named: model.imgName) {
                self.imgView.image = image
            }else{
                let url = URL(string: model.imgName ?? "")
                self.imgView.kf.setImage(with: url)
            }
        }
    }
    func setUpUI() {
        self.titleLabel.font = AppFont.appRegular(size: .body5)
        self.titleLabel.textColor = AppColor.eAnd_Black_80
    }
    
}

// MARK: - Cell Model
final class SavedBillCellModel: StandardCellModel {
    
    let title: String
    let imgName:String
    let listItems:[ListItems]?
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         imgName:String,
         methodType: MethodOptionsBaseTypes? = nil,
         listItems:[ListItems]? = nil) {
        self.title = title
        self.imgName = imgName
        self.methodType = methodType
        self.listItems = listItems
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SavedBillCell.identifier()
    }
}
