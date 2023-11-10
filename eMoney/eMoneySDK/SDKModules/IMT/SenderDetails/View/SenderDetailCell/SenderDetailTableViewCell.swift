//
//  SenderDetailTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 30/05/2023.
//

import UIKit
//import DropDown

class SenderDetailTableViewCell: StandardCell {
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var textFieldSender: StandardTextField!
    
    let dropDown = DropDown()
    
    // MARK: - Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupTextfieldDropDown(){
        if let model = cellModel as? SenderDetailTableViewCellModel,model.textFieldType == "dropdown" {
            textFieldSender.getTextField.inputView = UIView()
            textFieldSender.trailingButtonImage = "arrow-down"
            textFieldSender.textFieldDidBeginEditingCallback = { [unowned self] in
                customizeDropDown(dataSource: model.dropDownDataSource ?? [])
                
            }
        }
    }
        // MARK: - Update UI
        override func configureCell() {
            if let model = cellModel as? SenderDetailTableViewCellModel {
                textFieldSender.title = model.title
                textFieldSender.text = model.text
                textFieldSender.trailingButtonImage = model.image
                setupTextfieldDropDown()
            }
        }
        
        func customizeDropDown(dataSource:[String]) {
            
            dropDown.anchorView = self.textFieldSender as? any AnchorView
            dropDown.bottomOffset = CGPoint(x:0, y: self.textFieldSender.frame.height + 8)
            dropDown.cellHeight = 70
            dropDown.direction = .bottom
            dropDown.textFont = AppFont.appMedium(size: .body4)
            dropDown.textColor = AppColor.eAnd_Black_80
            dropDown.cancelAction = { [unowned self] in
                textFieldSender.resignFirstResponder()
            }
            
            // The list of items to display. Can be changed dynamically
            dropDown.dataSource = dataSource
            
            /*** IMPORTANT PART FOR CUSTOM CELLS ***/
            dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
            dropDown.backgroundColor = .white
            dropDown.setupCornerRadius(16)
            dropDown.customCellConfiguration = { index, item, cell in
//                guard let customCell = cell as? CustomDropDownCell else { return }
//                
//                if index == self.dropDown.dataSource.count - 1{
//                    customCell.separatorView.isHidden = true
//                }else{
//                    customCell.separatorView.isHidden = false
//                }
            }
            
            dropDown.selectionAction = { (index,item) in
                self.textFieldSender.text = item
                if let model = self.cellModel as? SenderDetailTableViewCellModel  {
                    model.text = item
                    model.actions?.cellSelected(index,model)
                }
                self.textFieldSender.resignFirstResponder()
            }
           
            dropDown.show()
        }
        
    }

// MARK: - Cell model
final class SenderDetailTableViewCellModel: StandardCellModel {
    
    let title: String
    var text: String
    let textFieldEntryType: StandardTextField.EntryType
    let textFieldType: String
    let image: String
    let dropDownDataSource:[String]?
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, text: String, textFieldEntryType: StandardTextField.EntryType, textFieldType: String, image: String, dropDownDataSource:[String]? = nil) {
        self.title = title
        self.text = text
        self.textFieldEntryType = textFieldEntryType
        self.textFieldType = textFieldType
        self.image = image
        self.dropDownDataSource = dropDownDataSource
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SenderDetailTableViewCell.identifier()
    }
}
