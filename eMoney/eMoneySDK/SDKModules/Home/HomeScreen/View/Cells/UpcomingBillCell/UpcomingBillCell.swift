//
//  UpcomingBillCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 16/04/2023.
//

import UIKit

final class UpcomingBillCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var lastRechargeLabel: UILabel!
    
    @IBOutlet weak var payBillButton: BaseButton!
    
    @IBOutlet weak var billOverDueView: UIView!
    @IBOutlet weak var overDueDateLabel: UILabel!
    
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = AppColor.eAnd_Grey_30
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupBillOverDueView()
    }
    
    override func configureCell() {
        if let cellModel = cellModel as? UpcomingBillCellModel {
            titleLabel.text = cellModel.title
            serviceNameLabel.text = cellModel.serviceName
            lastRechargeLabel.text = cellModel.lastRechargedDate
            serviceImageView.image = UIImage(named: cellModel.image)
            
            billOverDueView.superview?.isHidden = !cellModel.isOverDue
            lastRechargeLabel.isHidden = cellModel.isOverDue
            overDueDateLabel.text = "Overdue Feb 02"
            
            separatorView.isHidden = cellModel.isSeparatorHidden
        }
    }
    
    private func setupUI() {
        
        serviceImageView.cornerRadius = serviceImageView.frame.height / 2
        
        titleLabel.font = AppFont.appMedium(size: .body4)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        serviceNameLabel.font = AppFont.appRegular(size: .body5)
        serviceNameLabel.textColor = AppColor.eAnd_Grey_70
        
        lastRechargeLabel.font = AppFont.appRegular(size: .body5)
        lastRechargeLabel.textColor = AppColor.eAnd_Grey_70
        
        payBillButton.type = .GradientButton
    }
    
    private func setupBillOverDueView() {
        billOverDueView.cornerRadius = 10
        billOverDueView.backgroundColor = AppColor.eAnd_Error_10
        overDueDateLabel.font = AppFont.appRegular(size: .body4)
        overDueDateLabel.textColor = AppColor.eAnd_Error_100
    }
}

// MARK: - Cell model
final class UpcomingBillCellModel: StandardCellModel {
    let image: String
    let title: String
    let serviceName: String
    let lastRechargedDate: String
    let isOverDue: Bool
    let isSeparatorHidden: Bool
    
    init(actions: StandardCellModel.ActionsType = nil,
         image: String,
         title: String,
         serviceName: String,
         lastRechargedDate: String,
         isOverDue: Bool = false,
         isSeparatorHidden: Bool = false) {
        self.image = image
        self.title = title
        self.serviceName = serviceName
        self.lastRechargedDate = lastRechargedDate
        self.isOverDue = isOverDue
        self.isSeparatorHidden = isSeparatorHidden
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return UpcomingBillCell.identifier()
    }
}
