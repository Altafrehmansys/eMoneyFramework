//
//  MoneySendByBankTableViewCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 16/05/2023.
//

import UIKit

class MoneySendByBankTableViewCell: StandardCell {
    
    @IBOutlet weak var tagParentView: UIView!
    @IBOutlet weak var cellParentView: UIView!
    @IBOutlet weak var moneySentLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? MoneySendByBankTableViewCellModel {
            moneySentLabel.text = model.message
            moneySentLabel.font = model.messageFont
            moneySentLabel.textColor = model.messageColor
            
            timeLabel.text = model.time
            timeLabel.font = model.timeFont
            timeLabel.textColor = model.timeColor
            
            paidLabel.text = model.status
            paidLabel.font = model.statusFont
            paidLabel.textColor = model.statusColor
            
            amountLabel.text = model.amount
            amountLabel.font = model.amountFont
            amountLabel.textColor = model.amountColor
        }
    }
    func setUpUI(){
        cellParentView.cornerRadius =   12
        tagParentView.cornerRadius = 12
//      applyGradientColor(view: cellParentView)
    }
    
    func applyGradientColor(view:UIView){
        let layer0 = CALayer()
        layer0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        let layer1 = CAGradientLayer()
        layer1.colors = [
            UIColor(red: 0.969, green: 0.91, blue: 0.835, alpha: 1).cgColor,
            UIColor(red: 0.933, green: 0.463, blue: 0.439, alpha: 1).cgColor
        ]
        layer1.locations = [0, 1]
        layer1.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer1.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.45, b: 1.27, c: -0.5, d: 1.79, tx: 0.51, ty: -1.09))
        layer1.bounds = view.bounds.insetBy(dx: -0.5*view.bounds.size.width, dy: -0.5*view.bounds.size.height)
        layer1.position = view.center
        view.layer.addSublayer(layer1)
        
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    
    }
    
}

// MARK: - Cell Model
final class MoneySendByBankTableViewCellModel: StandardCellModel {
    
    let message: String
    let messageFont:UIFont
    let messageColor:UIColor
    
    let time: String
    let timeFont:UIFont
    let timeColor:UIColor
    
    let status: String
    let statusFont:UIFont
    let statusColor:UIColor
    
    let amount: String
    let amountFont:UIFont
    let amountColor:UIColor
    
    init(actions: StandardCellModel.ActionsType = nil,
         message: String,
         messageFont: UIFont = AppFont.appSemiBold(size: .body2),
         messageColor: UIColor = AppColor.eAnd_Black_80,
         time: String,
         timeFont: UIFont = AppFont.appRegular(size: .body5),
         timeColor: UIColor = AppColor.eAnd_Black_80,
         status: String,
         statusFont: UIFont = AppFont.appLight(size: .body4),
         statusColor: UIColor = AppColor.eAnd_Success_100,
         amount: String,
         amountFont: UIFont = AppFont.appSemiBold(size: .body3),
         amountColor: UIColor = AppColor.eAnd_Black_80) {
        self.message = message
        self.messageFont = messageFont
        self.messageColor = messageColor
        
        self.time = time
        self.timeFont = timeFont
        self.timeColor = timeColor
        
        self.status = status
        self.statusFont = statusFont
        self.statusColor = statusColor
        
        self.amount = amount
        self.amountFont = amountFont
        self.amountColor = amountColor
        
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return MoneySendByBankTableViewCell.identifier()
    }
    
    
}
