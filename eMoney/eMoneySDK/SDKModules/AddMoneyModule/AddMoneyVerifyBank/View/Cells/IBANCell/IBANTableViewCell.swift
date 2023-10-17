//
//  IBANTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 27/04/2023.
//

import UIKit

final class IBANTableViewCell: StandardCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ibanTextField: StandardTextField!
    
    
    // MARK: - Attributes
    let prefix = "AE "
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTextField()
    }
    
    override func configureCell() {
        if let model = cellModel as? IBANTableViewCellModel {
            titleLabel.text = model.title
            
            if !model.iban.isEmpty {
                ibanTextField.attributedText = model.iban.withBoldText(boldPartsOfString: [self.prefix], font: AppFont.appRegular(size: .body3), boldFont: AppFont.appSemiBold(size: .body2))
            }
            
            switch model.verificationStatus {
            case .verified:
                ibanTextField.showSuccess(with: Strings.AddMoney.accountVerified)
            case .notVerified:
                ibanTextField.showError(with: Strings.AddMoney.ibanError)
            default:
                ibanTextField.state = .normal
            }
        }
    }
}

// MARK: - Class Methods
extension IBANTableViewCell {
    private func setupTextField() {
        ibanTextField.title = Strings.AddMoney.iban
        ibanTextField.borderColor = AppColor.eAnd_Grey_20
        ibanTextField.trailingButtonImage = "info-circle"
        ibanTextField.showTitleWhenActive = true
        ibanTextField.entryType = .numberPad
        ibanTextField.state = .normal
        
        ibanTextField.trailingButtonTappedCallback = { [weak self] in
            if let model = self?.cellModel {
                model.actions?.cellSelected(1, model)
            }
        }
        
        self.setupDelegateForTextField()
    }
}

// MARK: - Configuration Of Text Field
private extension IBANTableViewCell {
    
    private func getAtrributed() -> NSAttributedString {
        return ibanTextField.text.withBoldText(boldPartsOfString: [self.prefix], font: AppFont.appRegular(size: .body3), boldFont: AppFont.appSemiBold(size: .body2))
    }
    
    func setupDelegateForTextField() {
        ibanTextField.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.ibanTextField.attributedText = self.getAtrributed()
            if let model = self.cellModel as? IBANTableViewCellModel {
                model.iban = self.getAtrributed().string
                model.actions?.cellSelected(0, model)
                self.ibanTextField.state = .normal
                self.ibanTextField.hideError()
            }
        }
        ibanTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            if !ibanTextField.text.contains(self.prefix) {
                self.addPrefix()
            }
        }
        ibanTextField.textFieldDidEndEditingCallback = { [weak self] in
            guard let self = self else { return }
            let str = self.ibanTextField.text.replacingOccurrences(of: self.prefix, with: "")
            // If user not added price the removing the prefix
            if str.isEmpty {
                self.removePrefix()
            }
        }

        ibanTextField.textFieldShouldChangeCharsInRnage = { range, replacement -> Bool in
            if !replacement.isDecimal && replacement.count > 0 {
                return false
            }
            let protectedRange = NSMakeRange(2, 1)
            let intersection = NSIntersectionRange(protectedRange, range)
            if intersection.length > 0 {
                return false
            }
            return true
        }
    }

    func addPrefix() {
        let attributedString = NSMutableAttributedString(string: self.prefix)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Black_80, range: NSMakeRange(0, 2))
        attributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appSemiBold(size: .body2), range: NSMakeRange(0, 2))
        ibanTextField.attributedText = attributedString
    }

    func removePrefix() {
        ibanTextField.text = ""
    }
}

// MARK: - Cell Model
final class IBANTableViewCellModel: StandardCellModel {
    
    enum VerificationStatus {
        case verified
        case notVerified
        case normal
    }
    
    let title: String
    var iban: String
    var verificationStatus: VerificationStatus
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         iban: String = "",
         verificationStatus: VerificationStatus = .normal) {
        self.title = title
        self.iban = iban
        self.verificationStatus = verificationStatus
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return IBANTableViewCell.identifier()
    }
}
