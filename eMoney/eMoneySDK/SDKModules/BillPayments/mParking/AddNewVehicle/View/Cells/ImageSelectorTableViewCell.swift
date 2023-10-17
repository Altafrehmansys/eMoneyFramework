//
//  ImageSelectorTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 02/06/2023.
//

import UIKit

class ImageSelectorTableViewCell: StandardCell {

    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var cellParentView: UIView!
    
    override func configureCell() {
        setUp()
        if let model = cellModel as? AddNewVehiclesTableViewCellModel {
        
            }
    }
    
    func setUp(){
        startTextField.font =  AppFont.appSemiBold(size: .body2)
        startTextField.textColor = AppColor.eAnd_Black_80
        endTextField.font =  AppFont.appSemiBold(size: .body2)
        endTextField.textColor = AppColor.eAnd_Black_80
        cellParentView.cornerRadius = 10
        childView.cornerRadius = 4
        childView.borderColor = AppColor.eAnd_Black_80
        childView.borderWidth = 1
    }
    
}

// MARK: - Cell Model
final class ImageSelectorTableViewCellModel: StandardCellModel {
  
    override init(actions: StandardCellModel.ActionsType = nil) {
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ImageSelectorTableViewCell.identifier()
    }
}
