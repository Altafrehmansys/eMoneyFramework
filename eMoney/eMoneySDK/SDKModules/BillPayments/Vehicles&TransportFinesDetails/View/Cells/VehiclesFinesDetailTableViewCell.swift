//
//  VehiclesFinesDetailTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//

import UIKit

class VehiclesFinesDetailTableViewCell: StandardCell {

    @IBOutlet weak var issuedByLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var serialNumberLabel: UILabel!
    @IBOutlet weak var cellSubView: UIView!
    @IBOutlet weak var cellParentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    override func configureCell() {
        if let model = self.cellModel as? VehiclesFinesDetailTableViewCellModel {
            self.issuedByLabel.text = model.issuedBy
            self.issuedByLabel.textColor = model.issuedByColor
            self.issuedByLabel.font = model.issuedByFont
            
            self.dateAndTimeLabel.text = model.dateAndTime
            self.dateAndTimeLabel.textColor = model.dateAndTimeColor
            self.dateAndTimeLabel.font = model.dateAndTimeFont
            
            self.amountLabel.text = model.amount
            self.amountLabel.textColor = model.amountColor
            self.amountLabel.font = model.amountFont
            
            self.serialNumberLabel.text = model.serialNumber
            self.serialNumberLabel.textColor = model.serialNumberColor
            self.serialNumberLabel.font = model.serialNumberFont
        }
    }
    func setUp(){
        cellParentView.cornerRadius = 12
       // cellSubView.roundCorners(corners: [.bottomRight,.bottomLeft], radius: 12)
        cellParentView.layer.borderColor = AppColor.eAnd_Success_10.cgColor
        cellParentView.layer.borderWidth = 1
    }
    
}

// MARK: - Cell Model
final class VehiclesFinesDetailTableViewCellModel: StandardCellModel {
    
    let serialNumber: String
    let serialNumberFont:UIFont
    let serialNumberColor:UIColor
    
    var amount: String
    let amountFont:UIFont
    let amountColor:UIColor
    
    let dateAndTime: String
    let dateAndTimeFont:UIFont
    let dateAndTimeColor:UIColor
    
    let issuedBy: String
    let issuedByFont:UIFont
    let issuedByColor:UIColor
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         serialNumber: String,
         serialNumberFont: UIFont = AppFont.appRegular(size: .body2),
         serialNumberColor: UIColor = AppColor.eAnd_Black_60,
         amount: String,
         amountFont: UIFont = AppFont.appSemiBold(size: .body2),
         amountColor: UIColor = AppColor.eAnd_Black_80,
         dateAndTime: String,
         dateAndTimeFont: UIFont = AppFont.appSemiBold(size: .body3),
         dateAndTimeColor: UIColor = AppColor.eAnd_Black_80,
         issuedBy: String,
         issuedByFont: UIFont = AppFont.appSemiBold(size: .body3),
         issuedByColor: UIColor = AppColor.eAnd_Black_80) {
        self.serialNumber = serialNumber
        self.serialNumberFont = serialNumberFont
        self.serialNumberColor = serialNumberColor
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        self.amount = amount
        self.dateAndTime = dateAndTime
        self.dateAndTimeFont = dateAndTimeFont
        self.dateAndTimeColor = dateAndTimeColor
        self.issuedBy = issuedBy
        self.issuedByFont = issuedByFont
        self.issuedByColor = issuedByColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return VehiclesFinesDetailTableViewCell.identifier()
    }
    
}
