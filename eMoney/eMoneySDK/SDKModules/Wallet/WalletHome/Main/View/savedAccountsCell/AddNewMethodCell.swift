//
//  AddNewMethodCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 11/07/2023.
//

import UIKit

class AddNewMethodCell: StandardCell {

    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? AddNewMethodCellModel {
            
            self.imgView.image = UIImage(named:model.image)
            self.methodLabel.text = model.title

        }
    }
    
    func setUpUI() {
        methodLabel.font = AppFont.appRegular(size:.body3)
        methodLabel.textColor = AppColor.eAnd_Black_80
    }
    
}

// MARK: - Cell Model
final class AddNewMethodCellModel: StandardCellModel {
    
    let image: String
    let title: String
    let methodType: MethodOptionsBaseTypes?
    init(actions: StandardCellModel.ActionsType = nil,
         image: String,
         title: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.image = image
        self.title = title
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewMethodCell.identifier()
    }
}
