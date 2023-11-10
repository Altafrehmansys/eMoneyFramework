//
//  SearchFieldTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 26/04/2023.
//

import UIKit

final class SearchFieldTableViewCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var trailingSearchIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func configureCell() {
        if let _ = cellModel as? SearchFieldTableViewCellModel {
            
        }
    }
}

// MARK: - Class Methods
extension SearchFieldTableViewCell {
    
    private func setup() {
        containerView.setProperties(cornerRadius: 16, borderColor: AppColor.eAnd_Grey_30, borderWidth: 1)
        
        searchField.font = AppFont.appRegular(size: .body2)
        searchField.tintColor = AppColor.eAnd_Red_100
        searchField.textColor = AppColor.eAnd_Black_80
        searchField.addTarget(self, action: #selector(textChangeListener), for: .editingChanged)
        searchField.delegate = self
        setupAttributedPlaceholder()
    }
    
    private func setupAttributedPlaceholder() {
        searchField.attributedPlaceholder = NSAttributedString(string: Strings.AddMoney.searchBankNameHere,
                                                               attributes: [NSAttributedString.Key.font: AppFont.appRegular(size: .body2),
                                                                            NSAttributedString.Key.foregroundColor: AppColor.eAnd_Grey_70])
        if let placeHolderLabel = searchField.value(forKey: "placeholderLabel") as? UILabel {
            placeHolderLabel.minimumScaleFactor = 0.5
            placeHolderLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func sendAction() {
        trailingSearchIcon.image = UIImage(named: self.image)
        if let model = cellModel as? SearchFieldTableViewCellModel {
            model.searchText = searchField.text ?? ""
            model.actions?.cellSelected(0, model)
        }
    }
    
    private var image: String {
        get {
            guard let text = searchField.text, !text.isEmpty else {
                return "search-normal"
            }
            
            return "Close"
        }
    }
}

// MARK: - Actions
extension SearchFieldTableViewCell {
    @objc func textChangeListener() {
        self.sendAction()
    }
    
    @IBAction func trailingButtonTapped(_ sender: UIButton) {
        guard let text = searchField.text, !text.isEmpty else {
            return
        }
        searchField.text = ""
        self.sendAction()
    }
}

// MARK: - Text field delegate methods
extension SearchFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = AppColor.eAnd_Black_80.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        containerView.layer.borderColor = AppColor.eAnd_Grey_30.cgColor
    }
}

// MARK: - Cell Model
final class SearchFieldTableViewCellModel: StandardCellModel {
    var searchText: String
    
    init(actions: StandardCellModel.ActionsType = nil, searchText: String = "") {
        self.searchText = searchText
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return SearchFieldTableViewCell.identifier()
    }
}
