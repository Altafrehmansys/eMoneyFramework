//
//  PlateTypeTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 02/06/2023.
//

import UIKit
import DropDown

class PlateTypeTableViewCell: StandardCell {
    let dropDown = DropDown()
    @IBOutlet weak var plateTypeView: StandardTextField!
    
    override func configureCell() {
        setUpTextField()
        if let model = cellModel as? PlateTypeTableViewCellModel {
            plateTypeView.title = model.plateTypePlaceholder
            plateTypeView.textFieldDidBeginEditingCallback = { [unowned self] in
                customizeDropDown(dataSource: model.dropDownDataSource ?? [])
            }
        }
    }
    
    func customizeDropDown(dataSource:[String]) {
        
        dropDown.anchorView = self.plateTypeView as? any AnchorView
        dropDown.bottomOffset = CGPoint(x:0, y: self.plateTypeView.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            plateTypeView.resignFirstResponder()
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCell else { return }
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        
        dropDown.selectionAction = { (index,item) in
            self.plateTypeView.text = item
            self.plateTypeView.resignFirstResponder()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    func setUpTextField(){
        plateTypeView.prefixFont = AppFont.appRegular(size: .body4)
        plateTypeView.textFieldTextColor = AppColor.eAnd_Black_80
        plateTypeView.getTextField.inputView = UIView()
        plateTypeView.trailingButtonImage = "arrow-down"
        
    }
}

// MARK: - Cell Model
final class PlateTypeTableViewCellModel: StandardCellModel {
    let plateTypePlaceholder:String
    let dropDownDataSource:[String]?
    init(plateTypePlaceholder:String, actions: StandardCellModel.ActionsType = nil,
         dropDownDataSource:[String]? = nil) {
        self.plateTypePlaceholder = plateTypePlaceholder
        self.dropDownDataSource = dropDownDataSource
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return PlateTypeTableViewCell.identifier()
    }
}
