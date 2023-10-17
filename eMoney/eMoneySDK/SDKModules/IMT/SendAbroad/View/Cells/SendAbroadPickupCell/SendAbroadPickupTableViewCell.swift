//
//  SendAbroadPickupTableViewCell.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 22/06/2023.
//

import UIKit

class SendAbroadPickupTableViewCell: StandardCell {
    @IBOutlet weak var textFieldRecieve: StandardTextField!
    @IBOutlet weak var viewExchange: UIView!
    @IBOutlet weak var imageViewArrowDown: UIImageView!
    @IBOutlet weak var imageViewCountry: UIImageView!
    @IBOutlet weak var labelToSend: UILabel!
    @IBOutlet weak var textFieldSend: StandardTextField!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var buttonTransfer: BaseButton!
    var uaeCurrency = "AED" + " "
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI() {
        viewContent.setProperties(cornerRadius: 20, borderColor: AppColor.eAnd_Grey_10, borderWidth: 1)
        viewContent.addShadow(shadowOpacity: 1, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 1), shadowColor: AppColor.eAnd_Shadow)
        buttonTransfer.type = .GradientButton
        buttonTransfer.setTitle("start_transfer".localized, for: .normal)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func configureSelectedCountryView() {
        labelToSend.text = "To India"
        labelToSend.textColor = AppColor.eAnd_Black_80
        labelToSend.font = AppFont.appSemiBold(size: .body2)
        
        self.textFieldSend.entryType = .decimal
        self.textFieldSend.title = "You send"
        self.textFieldSend.attributedText = "AED 100.00".withBoldText(boldPartsOfString: [self.uaeCurrency],
                                                                              font: AppFont.appRegular(size: .body2),
                                                                              boldFont: AppFont.appSemiBold(size: .body2))
        self.textFieldSend.state = .normal
        self.textFieldSend.setupConfigurations()
        
        self.textFieldRecieve.entryType = .decimal
        self.textFieldRecieve.title = "They receive"
        self.textFieldRecieve.attributedText = "INR 2,251.00".withBoldText(boldPartsOfString: ["INR "],
                                                                                     font: AppFont.appRegular(size: .body2),
                                                                                     boldFont: AppFont.appSemiBold(size: .body2))
        self.textFieldRecieve.state = .normal
        self.textFieldRecieve.setupConfigurations()
        
        viewExchange.cornerRadius = 16
        viewExchange.backgroundColor = AppColor.eAnd_Online_Exclusive.withAlphaComponent(0.50)
    }
    
    override func configureCell() {
        
        if let model = cellModel as? SendAbroadPickupTableViewCellModel {
            labelToSend.text = model.title
            configureSelectedCountryView()
        }
    }
    
    @IBAction func buttonTransferTapped(_ sender: Any) {
    }
}

// MARK: - Cell model
final class SendAbroadPickupTableViewCellModel: StandardCellModel {
    enum CurrentState {
        case selectCountry
        case transferring
    }
    
    let title: String
    var cellState: CurrentState
    
    init(actions: StandardCellModel.ActionsType = nil, title: String, cellState: CurrentState) {
        self.title = title
        self.cellState = cellState
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SendAbroadPickupTableViewCell.identifier()
    }
}
