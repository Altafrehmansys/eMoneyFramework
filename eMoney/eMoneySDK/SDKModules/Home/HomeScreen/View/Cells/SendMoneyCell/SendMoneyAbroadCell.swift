//
//  SendMoneyAbroadCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 13/04/2023.
//

import UIKit

class SendMoneyAbroadCell: StandardCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var startTransferButton: BaseButton!
    
    
    // MARK: - Unselected Country View Outlets
    @IBOutlet weak var unselectedCountryView: UIView!
    @IBOutlet weak var unselectedCountryViewTitleLabel: UILabel!
    @IBOutlet weak var countryFlagsCollectionView: UICollectionView!
    
    // MARK: - Selected Country View Outlets
    @IBOutlet weak var selectedCountryView: UIView!
    @IBOutlet weak var selectedCountryViewTitleLabel: UILabel!
    @IBOutlet weak var youSendMoneyTextField: StandardTextField!
    @IBOutlet weak var theyReceiveMoneyTextField: StandardTextField!
    @IBOutlet weak var exchangeRateView: UIView!
    
    // MARK: - Recent Transfer View Outlets
    @IBOutlet weak var recentTransferView: UIView!
    @IBOutlet weak var recentTransferTitleLabel: UILabel!
    @IBOutlet weak var recentTransferCollectionView: UICollectionView!
    
    
    // MARK: - Attributes
    var countryFlagsDataSource: [StandardCellModel] = []
    lazy var countryFlagsLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.minimumInteritemSpacing = 9.5
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    // MARK: - Attributes
    var recentTransferDataSource: [StandardCellModel] = []
    lazy var recentTransferLayout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 240, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    var uaeCurrency = "AED" + " "
    
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    private func setupUI() {
        
        containerView.setProperties(cornerRadius: 20, borderColor: AppColor.eAnd_Grey_10, borderWidth: 1)
        containerView.addShadow(shadowOpacity: 1, shadowRadius: 4, shadowOffset: CGSize(width: 0, height: 1), shadowColor: AppColor.eAnd_Shadow)
        
        titleLabel.textColor = AppColor.eAnd_Black_80
        titleLabel.font = AppFont.appSemiBold(size: .body2)
        startTransferButton.type = .GradientButton
        
        setupDelegateForYouSendMoneyTextField()
        setupDelegateForTheyReceiveMoneyTextField()
    }
    
    override func configureCell() {
        
        if let model = cellModel as? SendMoneyAbroadCellModel {
            titleLabel.text = model.title
            startTransferButton.setTitle("Start transfer", for: .normal)
            
            switch model.cellState {
            case .selectCountry:
                configureUnselectedCountryView()
            case .transferring:
                configureSelectedCountryView()
                configureRecentTransferView()
            }
            
            self.isHideUnselectedCountryView(model.cellState == .transferring)
        }
    }
    
    private func isHideUnselectedCountryView(_ status: Bool) {
        unselectedCountryView.isHidden = status
        selectedCountryView.isHidden = !status
        recentTransferView.isHidden = !status
    }
}

// MARK: - Unselected Country Configurations
extension SendMoneyAbroadCell {
    
    private func configureUnselectedCountryView() {
        unselectedCountryViewTitleLabel.text = "Send money to over 200 countries"
        unselectedCountryViewTitleLabel.textColor = AppColor.eAnd_Black_80
        unselectedCountryViewTitleLabel.font = AppFont.appMedium(size: .body4)
        
        configureCountryFlagsCollectionView()
    }
    
    private func configureCountryFlagsCollectionView() {
        countryFlagsCollectionView.dataSource = self
        countryFlagsCollectionView.delegate = self
        countryFlagsCollectionView.collectionViewLayout = countryFlagsLayout
        countryFlagsCollectionView.registerCell(type: CountryFlagCollectionViewCell.self)
        countryFlagsDataSource = Array.init(repeating: CountryFlagCollectionViewCellModel(flagImage: "Flag-India"), count: 10)
        countryFlagsCollectionView.reloadData()
    }
}

// MARK: - Selected Country Configurations
extension SendMoneyAbroadCell {
    private func configureSelectedCountryView() {
        selectedCountryViewTitleLabel.text = "To India"
        selectedCountryViewTitleLabel.textColor = AppColor.eAnd_Black_80
        selectedCountryViewTitleLabel.font = AppFont.appSemiBold(size: .body2)
        
        self.youSendMoneyTextField.entryType = .decimal
        self.youSendMoneyTextField.title = "You send"
        self.youSendMoneyTextField.attributedText = "AED 100.00".withBoldText(boldPartsOfString: [self.uaeCurrency],
                                                                              font: AppFont.appRegular(size: .body2),
                                                                              boldFont: AppFont.appSemiBold(size: .body2))
        self.youSendMoneyTextField.state = .normal
        self.youSendMoneyTextField.setupConfigurations()
        
        self.theyReceiveMoneyTextField.entryType = .decimal
        self.theyReceiveMoneyTextField.title = "They receive"
        self.theyReceiveMoneyTextField.attributedText = "INR 2,251.00".withBoldText(boldPartsOfString: ["INR "],
                                                                                     font: AppFont.appRegular(size: .body2),
                                                                                     boldFont: AppFont.appSemiBold(size: .body2))
        self.theyReceiveMoneyTextField.state = .normal
        self.theyReceiveMoneyTextField.setupConfigurations()
        
        exchangeRateView.cornerRadius = 16
        exchangeRateView.backgroundColor = AppColor.eAnd_Online_Exclusive.withAlphaComponent(0.50)
    }
}

// MARK: - Configuration Of Text Field
private extension SendMoneyAbroadCell {
    
    private func getAtrributedAmount(for textField: StandardTextField) -> NSAttributedString {
        return textField.text.withBoldText(boldPartsOfString: [self.uaeCurrency], font: AppFont.appRegular(size: .body2), boldFont: AppFont.appSemiBold(size: .body2))
    }
    
    func setupDelegateForYouSendMoneyTextField() {
        youSendMoneyTextField.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.youSendMoneyTextField.attributedText = self.getAtrributedAmount(for: self.youSendMoneyTextField)
            
        }
        youSendMoneyTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            if !youSendMoneyTextField.text.contains(uaeCurrency) {
                self.makePrefix(for: self.youSendMoneyTextField)
            }
        }
        youSendMoneyTextField.textFieldDidEndEditingCallback = { [weak self] in
            guard let self = self else { return }
            let str = self.youSendMoneyTextField.text.replacingOccurrences(of: self.uaeCurrency, with: "")
            // If user not added price the removing the prefix
            if str.isEmpty {
                self.removePrefix(from: self.youSendMoneyTextField)
            }
        }

        youSendMoneyTextField.textFieldShouldChangeCharsInRnage = { range, replacement -> Bool in
            if !replacement.isDecimal && replacement.count > 0 {
                return false
            }
            let protectedRange = NSMakeRange(3, 1)
            let intersection = NSIntersectionRange(protectedRange, range)
            if intersection.length > 0 {
                return false
            }
            return true
        }
    }
    
    func setupDelegateForTheyReceiveMoneyTextField() {
        theyReceiveMoneyTextField.textChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.theyReceiveMoneyTextField.attributedText = self.getAtrributedAmount(for: self.theyReceiveMoneyTextField)
        }
        theyReceiveMoneyTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            if !theyReceiveMoneyTextField.text.contains(uaeCurrency) {
                self.makePrefix(for: theyReceiveMoneyTextField)
            }
        }
        theyReceiveMoneyTextField.textFieldDidEndEditingCallback = { [weak self] in
            guard let self = self else { return }
            let str = self.theyReceiveMoneyTextField.text.replacingOccurrences(of: self.uaeCurrency, with: "")
            // If user not added price the removing the prefix
            if str.isEmpty {
                self.removePrefix(from: self.theyReceiveMoneyTextField)
            }
        }

        theyReceiveMoneyTextField.textFieldShouldChangeCharsInRnage = { range, replacement -> Bool in
            if !replacement.isDecimal && replacement.count > 0 {
                return false
            }
            let protectedRange = NSMakeRange(3, 1)
            let intersection = NSIntersectionRange(protectedRange, range)
            if intersection.length > 0 {
                return false
            }
            return true
        }
    }

    func makePrefix(for textField: StandardTextField) {
        let attributedString = NSMutableAttributedString(string: uaeCurrency)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: AppColor.eAnd_Black_80, range: NSMakeRange(0, 4))
        attributedString.addAttribute(NSAttributedString.Key.font, value: AppFont.appSemiBold(size: .body2), range: NSMakeRange(0, 4))
        textField.attributedText = attributedString
    }

    func removePrefix(from textField: StandardTextField) {
        textField.text = ""
    }
}

// MARK: - Recent Transfer Configurations
extension SendMoneyAbroadCell {
    private func configureRecentTransferView() {
        recentTransferTitleLabel.text = "Or repeat recent transfer"
        unselectedCountryViewTitleLabel.textColor = AppColor.eAnd_Black_80
        unselectedCountryViewTitleLabel.font = AppFont.appMedium(size: .body4)
        
        configureRecentTransferCollectionView()
    }
    
    private func configureRecentTransferCollectionView() {
        recentTransferCollectionView.dataSource = self
        recentTransferCollectionView.delegate = self
        recentTransferCollectionView.collectionViewLayout = recentTransferLayout
        recentTransferCollectionView.registerCell(type: RecentTransferCollectionViewCell.self)
        recentTransferCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        recentTransferDataSource = Array.init(repeating: RecentTransferCollectionViewCellModel(name: "Khan Mohammad", amount: "AED 5,000.00", userImage: "Flag-India", countryFlagImage: "Flag-India"), count: 10)
        recentTransferCollectionView.reloadData()
    }
}

// MARK: - Actions
extension SendMoneyAbroadCell {
    @IBAction func startTransferButtonAction(_ sender: BaseButton) {
        if let model = cellModel as? SendMoneyAbroadCellModel {
            model.actions?.cellSelected(0, model)
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension SendMoneyAbroadCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if collectionView == recentTransferCollectionView {
            return recentTransferDataSource.count
        } else if collectionView == countryFlagsCollectionView {
            return countryFlagsDataSource.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recentTransferCollectionView {
            let model = recentTransferDataSource[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier(), for: indexPath) as? StandardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellModel = model
            return cell
        } else if collectionView == countryFlagsCollectionView {
            let model = countryFlagsDataSource[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier(), for: indexPath) as? StandardCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellModel = model
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - Cell model
final class SendMoneyAbroadCellModel: StandardCellModel {
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
        return SendMoneyAbroadCell.identifier()
    }
}
