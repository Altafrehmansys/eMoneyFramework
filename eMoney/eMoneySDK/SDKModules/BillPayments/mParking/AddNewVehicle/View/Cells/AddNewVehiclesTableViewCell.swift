//
//  AddNewVehiclesTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//

import UIKit

class AddNewVehiclesTableViewCell: StandardCell {

    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Override Methods
    override func configureCell() {
       
        setUp()
        if let model = cellModel as? AddNewVehiclesTableViewCellModel {
            self.titleLabel.text = model.title

            }
    }
    
    func setUp(){
        titleLabel.font =  AppFont.appRegular(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
    }
    
}
// MARK: - Cell Model
final class AddNewVehiclesTableViewCellModel: StandardCellModel {
    let title: String
    init(actions: StandardCellModel.ActionsType = nil,
         title:String) {
        self.title = title
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return AddNewVehiclesTableViewCell.identifier()
    }
}
