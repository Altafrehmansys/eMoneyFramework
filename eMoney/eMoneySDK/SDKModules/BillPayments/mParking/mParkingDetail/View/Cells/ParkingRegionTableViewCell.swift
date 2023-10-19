//
//  ParkingRegionTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 31/05/2023.
//

import UIKit
//import DropDown

class ParkingRegionTableViewCell: StandardCell {

    @IBOutlet weak var parkingRegionView: StandardTextField!
    let dropDown = DropDown()

    // MARK: - Override Methods
    override func configureCell() {
       
        setUpTextField()
        if let model = cellModel as? ParkingRegionTableViewCellModel {
            self.parkingRegionView.title = model.dropDownPlaceHolderText
            parkingRegionView.textFieldDidBeginEditingCallback = { [unowned self] in
                customizeDropDown(dataSource: model.dataSource ?? [], imageDataSource: model.imageDataSource ?? [])
            }
            
        }
    }
    
    func setUpTextField(){
        parkingRegionView.prefixFont = AppFont.appRegular(size: .body4)
        parkingRegionView.textFieldTextColor = AppColor.eAnd_Black_80
        parkingRegionView.getTextField.inputView = UIView()
        parkingRegionView.trailingButtonImage = "arrow-down"
       // parkingRegionView.leadingButtonImage = "etisalat-icon"
    }
    
    func customizeDropDown(dataSource:[String],imageDataSource:[String]) {
      
        dropDown.anchorView = self.parkingRegionView as? any AnchorView
        dropDown.anchorView = self.parkingRegionView
        dropDown.bottomOffset = CGPoint(x:0, y: self.parkingRegionView.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            parkingRegionView.resignFirstResponder()
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource

        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCellWithImageTableViewCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCellWithImageTableViewCell else { return }
            if let imageURL = URL(string:imageDataSource[index]) {
                customCell.imgView.load(url: imageURL)
            }
            customCell.imgView.image = UIImage(named:imageDataSource[index])
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        
        dropDown.selectionAction = { (index,item) in
            self.parkingRegionView.text = item
            self.parkingRegionView.leadingButtonImage = imageDataSource[index]
            self.parkingRegionView.setupConfigurations()
            self.parkingRegionView.resignFirstResponder()
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    
}

// MARK: - Cell Model
final class ParkingRegionTableViewCellModel: StandardCellModel {
    let dropDownPlaceHolderText: String
    let dataSource:[String]?
    let imageDataSource:[String]?
    init(actions: StandardCellModel.ActionsType = nil,
         dropDownPlaceHolderText:String,dataSource:[String]? = nil,imageDataSource:[String]? = nil) {
        self.dropDownPlaceHolderText = dropDownPlaceHolderText
        self.dataSource = dataSource
        self.imageDataSource = imageDataSource
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ParkingRegionTableViewCell.identifier()
    }
}
