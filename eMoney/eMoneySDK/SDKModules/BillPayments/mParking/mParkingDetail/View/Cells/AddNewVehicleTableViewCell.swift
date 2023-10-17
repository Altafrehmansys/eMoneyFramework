//
//  AddNewVehicleTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//

import UIKit

class AddNewVehicleTableViewCell: StandardCell {

    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func configureCell() {
       
        setUpTextField()
        if let model = cellModel as? AddNewVehicleTableViewCellModel {
            self.titleLabel.text = model.title
        }
    }
    
    func setUpTextField(){
        titleLabel.font = AppFont.appRegular(size: .body3)
        titleLabel.textColor = AppColor.eAnd_Black_80
        cellParentView.cornerRadius = 12
        cellParentView.borderWidth = 1
        cellParentView.borderColor = AppColor.eAnd_Grey_30
    }
    
}
// MARK: - Cell Model
final class AddNewVehicleTableViewCellModel: StandardCellModel {
    let title: String
    init(actions: StandardCellModel.ActionsType = nil,
         title:String) {
        self.title = title
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewVehicleTableViewCell.identifier()
    }
}
