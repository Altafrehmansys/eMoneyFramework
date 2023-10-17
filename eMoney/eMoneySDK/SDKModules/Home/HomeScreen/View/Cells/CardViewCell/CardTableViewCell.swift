//
//  CardTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 18/04/2023.
//

import UIKit

final class CardTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var notificationView: UIView! {
        didSet {
            notificationView.isHidden = true
        }
    }
    @IBOutlet weak var notificationTitleLabel: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var balanceCurrencyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardProviderImageView: UIImageView!
    @IBOutlet weak var cardNameLabelTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var addMoneyButton: BaseButton!
    
    // MARK: - Attributes
    var defaultTrailingInset = 8.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    
    private func setupUI() {
        notificationView.cornerRadius = notificationView.frame.size.height / 2
        notificationView.backgroundColor = AppColor.eAnd_Limited_Offer
        
        let attributedTitle = "You’re eligible for a AED 2,000 cash advance!"
        notificationTitleLabel.attributedText = attributedTitle.withBoldText(boldPartsOfString: ["AED 2,000 cash advance!"], font: AppFont.appLight(size: .body4), boldFont: AppFont.appMedium(size: .body4))
        notificationTitleLabel.textColor = AppColor.eAnd_Black_80
        
        cardView.backgroundColor = AppColor.eAnd_Red_100
        cardView.cornerRadius = 12
        
        
        cardNameLabel.text = "e& money card"
        cardNameLabel.font = AppFont.appRegular(size: .body4)
        cardNameLabel.textColor = AppColor.eAnd_White
        
        balanceCurrencyLabel.text = "Balance (AED)"
        balanceCurrencyLabel.font = AppFont.appLight(size: .body3)
        balanceCurrencyLabel.textColor = AppColor.eAnd_White
        balanceCurrencyLabel.lineHeight = 20
        
        balanceLabel.text = "00.00"
        balanceLabel.font = AppFont.appSemiBold(size: .h5)
        balanceLabel.textColor = AppColor.eAnd_White
        balanceLabel.lineHeight = 36
        
        cardProviderImageView.image = UIImage(named: "MasterCard")
        
        cardNumberLabel.text = "*** 5763"
        cardNumberLabel.font = AppFont.appRegular(size: .body5)
        cardNumberLabel.textColor = AppColor.eAnd_White
        
        addMoneyButton.type = .BorderButton
        let profile = GlobalData.shared.userProfile
        let btnTitle = profile == .physicalKYC ? Strings.AddMoney.addMoneyTitle : Strings.AddMoney.completeRegistrationTitle
        addMoneyButton.setTitle(btnTitle, for: .normal)
        addMoneyButton.titleLabel?.font = AppFont.appMedium(size: .body4)
        
        
        cardNameLabelTrailingConstraint.constant = defaultTrailingInset - ((cardNameLabel.frame.width/2) + (cardNameLabel.frame.height/2))
        cardNameLabel.transform = CGAffineTransform(rotationAngle: .pi/2*3)
    }
    
    // MARK: - Update UI
    override func configureCell() {
        if let model = cellModel as? CardTableViewCellModel {
            balanceCurrencyLabel.text = "Balance (\(model.balanceData?.currency ?? "AED"))"
            balanceLabel.text = model.balanceData?.balance?.formattedAmountWithComma
        }
    }
}

// MARK: - IBActions
extension CardTableViewCell {
    @IBAction func addMoneyTapped(_ sender: UIButton) {
        if let model = cellModel as? CardTableViewCellModel {
            model.actions?.cellSelected(0, model)
        }
    }
}


// MARK: - Class Model
final class CardTableViewCellModel: StandardCellModel {
    let title: String
    let balanceData:AvailableBalanceData?
    let notificationObject: AnyObject?
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String, balance:AvailableBalanceData?,
         notificationObject: AnyObject? = nil) {
        self.title = title
        self.balanceData = balance
        self.notificationObject = notificationObject
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return CardTableViewCell.identifier()
    }
}
