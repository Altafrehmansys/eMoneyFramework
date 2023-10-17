//
//  ParkingStatusTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//

import UIKit

class ParkingStatusTableViewCell: StandardCell {

    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellParentView: UIView!
    
    override func configureCell() {
       
        setUpTextField()
        if let model = cellModel as? ParkingStatusTableViewCellModel {
            self.titleLabel.text = model.title
        }
    }
    
    func setUpTextField(){
        
        cellParentView.backgroundColor = AppColor.eAnd_Success_10
        titleLabel.font = AppFont.appRegular(size: .body3)
        titleLabel.textColor = AppColor.eAnd_Black_80
        cellParentView.cornerRadius = 8
    }
    
}

// MARK: - Cell Model
final class ParkingStatusTableViewCellModel: StandardCellModel {
    let title: String
    init(actions: StandardCellModel.ActionsType = nil,
         title:String) {
        self.title = title
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return ParkingStatusTableViewCell.identifier()
    }
}
