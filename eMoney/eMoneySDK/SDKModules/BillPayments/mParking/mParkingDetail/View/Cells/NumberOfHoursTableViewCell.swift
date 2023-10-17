//
//  NumberOfHoursTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//

import UIKit
import DropDown

class NumberOfHoursTableViewCell: StandardCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var parkingLabel: UILabel!
    @IBOutlet weak var dropDownView: StandardTextField!
    @IBOutlet weak var cellParentView: UIView!
    let dropDown = DropDown()
    // MARK: - Override Methods
    override func configureCell() {
       
        setUpTextField()
        if let model = cellModel as? NumberOfHoursTableViewCellModel {
            self.dropDownView.title = model.dropDownPlaceHolderText
            dropDownView.textFieldDidBeginEditingCallback = { [unowned self] in
                customizeDropDown(dataSource: model.dropDownDataSource ?? [])
            }
            
        }
    }
    
    func customizeDropDown(dataSource:[String]) {
      
        dropDown.anchorView = self.dropDownView as? any AnchorView
        dropDown.bottomOffset = CGPoint(x:0, y: self.dropDownView.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            dropDownView.resignFirstResponder()
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
            self.dropDownView.text = item
            self.dropDownView.resignFirstResponder()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    
    func setUpTextField(){
        dropDownView.prefixFont = AppFont.appRegular(size: .body4)
        dropDownView.textFieldTextColor = AppColor.eAnd_Black_80
        dropDownView.getTextField.inputView = UIView()
        dropDownView.trailingButtonImage = "arrow-down"
        parkingLabel.text = "Parking fees"
        parkingLabel.textColor = AppColor.eAnd_Grey_100
        parkingLabel.font = AppFont.appRegular(size: .body4)
        amountLabel.text = "AED ---"
        amountLabel.textColor = AppColor.eAnd_Black_80
        amountLabel.font = AppFont.appRegular(size: .body2)
        cellParentView.cornerRadius = 16
        
        
        
    }
}

// MARK: - Cell Model
final class NumberOfHoursTableViewCellModel: StandardCellModel {
    let dropDownPlaceHolderText: String
    let parkingFee:String
    let dropDownDataSource:[String]?
 
    init(actions: StandardCellModel.ActionsType = nil,
         dropDownPlaceHolderText:String,
         parkingFee: String,
         dropDownDataSource:[String]? = nil) {
        self.dropDownPlaceHolderText = dropDownPlaceHolderText
        self.parkingFee = parkingFee
        self.dropDownDataSource = dropDownDataSource
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return NumberOfHoursTableViewCell.identifier()
    }
}
