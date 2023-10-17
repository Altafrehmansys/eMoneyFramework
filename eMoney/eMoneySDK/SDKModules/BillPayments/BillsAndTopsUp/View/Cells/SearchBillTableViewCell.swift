//
//  SearchBillTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 06/06/2023.
//

import UIKit

class SearchBillTableViewCell: StandardCell {

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var cellParentView: UIView!
   

    override func configureCell() {
        setUpUI()
        if let model = cellModel as? SearchBillTableViewCellModel {
            self.btnSearch.setTitle(model.searchPlaceHolder, for: .normal)
        }
    }
    func setUpUI() {
        self.cellParentView.cornerRadius = 16
        self.cellParentView.borderWidth = 1
        self.cellParentView.borderColor = AppColor.eAnd_Grey_30
        self.btnSearch.titleLabel?.font = AppFont.appRegular(size: .body2)
        self.btnSearch.setTitleColor(AppColor.eAnd_Grey_70,for: .normal)
    }
}

// MARK: - Cell Model
final class SearchBillTableViewCellModel: StandardCellModel {
    
    let searchPlaceHolder: String
    let methodType: MethodOptionsBaseTypes?
    
    init(actions: StandardCellModel.ActionsType = nil,
         searchPlaceHolder: String,
         methodType: MethodOptionsBaseTypes? = nil) {
        self.searchPlaceHolder = searchPlaceHolder
        self.methodType = methodType
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return SearchBillTableViewCell.identifier()
    }
}
