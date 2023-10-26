//
//  StandardTextField.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 06/04/2023.
//

import UIKit

@IBDesignable
final class StandardTextField: UIView {
    
    enum `EntryType`: Equatable {
        case password
        case phoneNumber
        case internationalPhoneNumber
        case text
        case email
        case decimal
        case numberPad
        
        var isLeadingViewHidden: Bool {
            switch self {
            case .password, .phoneNumber, .internationalPhoneNumber:
                return false
            default:
                return true
            }
        }
        
        var isTrailingViewHidden: Bool {
            switch self {
            case .password:
                return false
            default:
                return true
            }
        }
        
        var leadingImage: String {
            switch self {
            case .password:
                return "lock-icon"
            default:
                return ""
            }
        }
        
        var trailingImage: String {
            switch self {
            case .password:
                return "show_password"
            default:
                return "Close-icon"
            }
        }
        
        var isTitleHidden: Bool {
            switch self {
            case .phoneNumber, .internationalPhoneNumber:
                return true
            default:
                return false
            }
        }
        
        var characterLimit: Int {
            switch self {
            case .phoneNumber:
                return 9
            default:
                return self.characterLimit
            }
        }
    }
    
    enum States {
        case error
        case disabled
        case success
        case normal
        case focus
        case clear
        
        var backgroundColor: UIColor {
            switch self {
            case .disabled:
                return AppColor.eAnd_Grey_10
            default:
                return .clear
            }
        }
        
        var borderColor: CGColor {
            switch self {
            case .error:
                return AppColor.eAnd_Error_100.cgColor
            case .disabled:
                return AppColor.eAnd_Grey_30.cgColor
            case .success:
                return AppColor.eAnd_Success_100.cgColor
            case .normal:
//                return UIColor.gray.withAlphaComponent(0.5).cgColor
                return AppColor.eAnd_Grey_50.cgColor
            case .focus:
                return AppColor.eAnd_Black_80.cgColor
            case .clear:
                return UIColor.clear.cgColor
            }
        }
        
        var color: UIColor {
            switch self {
            case .error:
                return AppColor.eAnd_Error_100
            case .disabled:
                return AppColor.eAnd_Grey_70
            case .success:
                return AppColor.eAnd_Success_100
            case .normal:
                return AppColor.eAnd_Black_80
            case .focus:
                return AppColor.eAnd_Black_80
            case .clear:
                return UIColor.clear
            }
        }
        
        var textFieldTextColor: UIColor {
            switch self {
            case .disabled:
                return AppColor.eAnd_Grey_70
            default:
                return AppColor.eAnd_Black_80
            }
        }
        
        var isUserInteractionEnabled: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
    }
    
    // MARK: - Private Outlets
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView! {
        didSet {
           // self.state = .normal
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = cornerRadiusTextField
        }
    }
    @IBOutlet private weak var charactersCountLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var leadingButton: BaseButton!
    @IBOutlet private weak var trailingButton: BaseButton!
    @IBOutlet private weak var leadingButtonImageView: UIImageView!
    @IBOutlet private weak var trailingButtonImageView: UIImageView!
    @IBOutlet private weak var leadingStackView: UIStackView!
    @IBOutlet private weak var trailingStackView: UIStackView!
    @IBOutlet private weak var textFieldBottomView: UIView! {
        didSet {
            textFieldBottomView.isHidden = true
        }
    }
    
    
    // MARK: - Private Properties
    private var placeHolderString: String = ""
    private var titleString: String = ""
    private var view: UIView!
    private var allowedCharacters: String?
    private var charactersLimit = 200
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StandardTextField.tapGestureRecognized(_:)))
    private let phoneNumberString = "0123456789 "
    private let decimalsOnlyString = "0123456789."
    
    
    // MARK: - Public Properties
    var textChangedCallback: (() -> Void)?
    var textFieldDidBeginEditingCallback: (() -> Void)?
    var textFieldDidEndEditingCallback: (() -> Void)?
    var textFieldShouldChangeCharsInRnage: ((_ range: NSRange, _ replacement: String) -> (Bool))?
    var leadingButtonTappedCallback: (() -> Void)?
    var trailingButtonTappedCallback: (() -> Void)?
    var entryType: EntryType = .text { didSet { self.setupTextFieldOnTypeChanges() } }
    
    /// Get the Text field
    var getTextField: UITextField {
        get {
            return self.textField
        }
    }
    
    /// Set the state of Text field
    var state: States = .normal {
        didSet { self.changeStateIfNeeded() }
    }
    
    /// Color of Text in text field
    var textFieldTextColor: UIColor = AppColor.eAnd_Black_80
    
    /// Sets the color of the title text when textfield is first responder / not
    var activeTitleLabelColor: UIColor = AppColor.eAnd_Grey_100
    var inactiveTitleLabelColor: UIColor = AppColor.eAnd_Grey_50
    
    /// Sets the text size of title label
    var textFieldFont: UIFont = AppFont.appRegular(size: .body2)
    
    /// Check for to set `TextField` hidden or not
    private var isTextFieldSetHidden: Bool {
        get {
            return self.text.isEmpty && !self.textField.isFirstResponder && self.placeHolderString.isEmpty
        }
    }
    
    /// Set the font of `Title Label` according to the Text field hidden state
    private var titleLabelFont: UIFont {
        get {
            return !isTextFieldSetHidden ? AppFont.appRegular(size: .body4) : AppFont.appRegular(size: .body2)
        }
        set(newFont) {
            titleLabel.font = !isTextFieldSetHidden ? AppFont.appRegular(size: .body4) : newFont
        }
    }
    
    /// set image for Leading button
    var leadingButtonImage: String? {
        didSet {
            if let leadingButtonImage {
                if let image =  UIImage(named: leadingButtonImage) {
                    self.leadingButtonImageView.image = image
                }else if let url = URL(string: leadingButtonImage){
                    self.leadingButtonImageView.load(url: url)
                }
                
            }
        }
    }
    
    var postFix: String? {
        didSet {
            if let postFix {
                self.trailingButton.setTitle(postFix, for: .normal)
            }
        }
    }
    /// set image for Leading button
    var postFixFont: UIFont? {
        didSet {
            if let postFixFont {
                self.trailingButton.titleLabel?.font = postFixFont
            }
        }
    }
    /// set image for Leading button
    var postFixColor: UIColor? {
        didSet {
            if let postFixColor {
                self.trailingButton.setTitleColor(postFixColor, for: .normal)
            }
        }
    }
    
    /// set image for Leading button
    var prefix: String? {
        didSet {
            if let prefix {
                self.leadingButton.setTitle(prefix, for: .normal)
            }
        }
    }
    /// set image for Leading button
    var prefixFont: UIFont? {
        didSet {
            if let prefixFont {
                self.leadingButton.titleLabel?.font = prefixFont
            }
        }
    }
    /// set image for Leading button
    var prefixColor: UIColor? {
        didSet {
            if let prefixColor {
                self.leadingButton.setTitleColor(prefixColor, for: .normal)
            }
        }
    }
    
    /// set image for trailing button
    var trailingButtonImage: String? {
        didSet {
            if let trailingButtonImage {
                self.trailingButtonImageView.image = UIImage(named: trailingButtonImage)
            }
        }
    }
    
    /// If you want to show Characters count then this check needs to set `true`
    var showCharactersCount: Bool = false {
        didSet {
            self.charactersCountLabel.isHidden = !showCharactersCount
            self.textFieldBottomView.isHidden = !showCharactersCount
        }
    }
    
    /// adds spaces between phone nuber segments. default is true
    var shouldFormatPhoneNumber = true
    
    // MARK: - IBInspectable Properties
    @IBInspectable var title: String? {
        get {
            return titleString
        } set(newText) {
            titleString = newText ?? ""
            titleLabel.text = newText
        }
    }
    
    /**
     The instance of the `View`  has filed name TextField.
     User can set view  text to filed
     */
    @IBInspectable var text: String {
        get {
            return textField.text ?? ""
        }
        set(newText) {
            textField.text = newText
            switch entryType {
            case .phoneNumber,.internationalPhoneNumber:
                textField.text = newText.formattedPhoneNumber
            default:
                textField.text = newText
            }
        }
    }
    @IBInspectable var attributedText: NSAttributedString {
        get {
            return textField.attributedText ?? NSAttributedString(string: "")
        } set(newText) {
            textField.attributedText = newText
        }
    }
    @IBInspectable var placeholder: String? {
        get {
            return placeHolderString
        } set(newText) {
            placeHolderString = newText ?? ""
            setPlaceholderText()
        }
    }
    
    @IBInspectable var showTitleWhenActive: Bool = true { didSet {
        changeTitleLabelColorIfNeeded()
    }}
    
    /**
     The isSecureTextEntry of the `View` instance.
     User can set  bool value for SecureTextEntry
     */
    @IBInspectable var isSecureTextEntry: Bool {
        get {
            return textField.isSecureTextEntry
        } set(newVal) {
            textField.isSecureTextEntry = newVal
        }
    }
    
    /**
     The textLimit of the `View` instance filed of textfield.
     User can set  textLimit to textField
     */
    @IBInspectable var textLimit: Int {
        get {
            return charactersLimit
        } set(newVal) {
            charactersLimit = newVal
        }
    }
    
    /// Set the corner radius for the text field, Default value would be 16.0
    @IBInspectable var cornerRadiusTextField: CGFloat {
        get {
            return 16.0
        } set(newVal) {
            containerView.layer.cornerRadius = newVal
        }
    }
    
    
    // MARK: - Override Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: view.frame.width, height: 64)
    }
}


// MARK: - Private Methods
extension StandardTextField {
    override func layoutSubviews() {
        super.layoutSubviews()
        overrideUserInterfaceStyle = .light
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        overrideUserInterfaceStyle = .light
    }
    
    func setupConfigurations(state:States = .normal) {
        self.state = state
        titleLabel.font = titleLabelFont
        titleLabel.isHidden = entryType.isTitleHidden
        textField.textColor = textFieldTextColor
        self.overrideUserInterfaceStyle = .light
        if let attributedText = textField.attributedText, attributedText.string.isEmpty {
            textField.font = textFieldFont
        }
        
        //setPlaceholderText()
        
        leadingStackView.isHidden = entryType.isLeadingViewHidden && leadingButtonImage == nil
        trailingStackView.isHidden = (entryType.isTrailingViewHidden && trailingButtonImage == nil) && postFix == nil
        
        errorLabel.font = AppFont.appRegular(size: .body4)
        charactersCountLabel.font = AppFont.appRegular(size: .body4)
        charactersCountLabel.text = "\(text.count)/\(charactersLimit)"
        
        let leadingImageName = leadingButtonImage == nil ? entryType.leadingImage : leadingButtonImage!
        leadingButtonImageView.image = UIImage(named: leadingImageName)
        
        let trailingImageName = trailingButtonImage == nil ? entryType.trailingImage : trailingButtonImage!
        trailingButtonImageView.image = UIImage(named: trailingImageName)
    }
    
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        DispatchQueue.main.async { [unowned self] in // To avoid some unexpected behaviours, make sure all UI setup is done in main thread
            addSubview(view)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
                view.topAnchor.constraint(equalTo: topAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            let textAlignment: NSTextAlignment = LocaleManager.isRTLLanguage() ? .right : .left
            textField.textAlignment = textAlignment
            textField.delegate = self
            textField.textColor = textFieldTextColor
            textField.font = textFieldFont
            textField.addTarget(self, action: #selector(StandardTextField.textFieldTextDidChange(_:)), for: UIControl.Event.editingChanged)
            
            self.setupConfigurations()
            
            addGestureRecognizer(tapGestureRecognizer)
        }
        
        view.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func loadViewFromNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        let nib = UINib(nibName: String(describing: StandardTextField.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.overrideUserInterfaceStyle = .light
        return view
    }
    
    private func setPlaceholderText() {
        if entryType == .phoneNumber || entryType == .internationalPhoneNumber {
            self.setAttributedPlaceHolder(placeHolderString)
        } else {
            if let title, !title.isEmpty, let placeholder, !placeholder.isEmpty {
                titleLabel.text = title
                self.setAttributedPlaceHolder(placeholder)
            } else {
                if let title, !title.isEmpty {
                    titleLabel.text = title
                } else if !placeHolderString.isEmpty {
                    titleLabel.text = placeholder
                }
            }
        }
    }
    
    private func setAttributedPlaceHolder(_ string: String) {
        textField.attributedPlaceholder = NSAttributedString(string: string)
        if let placeHolderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
            placeHolderLabel.minimumScaleFactor = 0.5
            placeHolderLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setupTextFieldOnTypeChanges() {
        switch entryType {
        case .phoneNumber,.internationalPhoneNumber:
            allowedCharacters = phoneNumberString
            textField.keyboardType = .numberPad
        case .internationalPhoneNumber:
            allowedCharacters = phoneNumberString
            textField.keyboardType = .numberPad
        case .decimal:
            allowedCharacters = decimalsOnlyString
            textField.keyboardType = .decimalPad
            
        case .email:
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            
        case .text:
            textField.keyboardType = .default
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.inputView = nil
            textField.inputAccessoryView = nil
            
        case .password:
            textField.isSecureTextEntry = true
            textField.keyboardType = .default
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            
        case .numberPad:
            textField.keyboardType = .numberPad
        }
    }
    
    private func changeTitleLabelColorIfNeeded(withAnimation: Bool = true) {
        if traitCollection.userInterfaceStyle == .light {
            containerView.layer.borderColor = state.borderColor
        } else {
            containerView.layer.borderColor = state.borderColor
        }
        
        titleLabel.textColor = textField.isFirstResponder ? AppColor.eAnd_Grey_100 : AppColor.eAnd_Grey_50
        
        UIView.animate(withDuration: withAnimation ? 0.2 : 0) {
            self.textField.alpha = self.isTextFieldSetHidden ? 0 : 1
            self.textField.isHidden = self.isTextFieldSetHidden
            self.titleLabel.font = self.titleLabelFont
        }
    }
    
    private func textfieldIsSecureToggle() {
        textField.isSecureTextEntry.toggle()
        
        let imageName = textField.isSecureTextEntry ? "show_password" : "hide_password"
        trailingButtonImage = imageName
    }
}

// MARK: - Actions
extension StandardTextField {
    @objc private func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @objc private func textFieldTextDidChange(_ textField: UITextField) {
        textChangedCallback?()
    }
    
    @IBAction func leadingButtonTappedAction(_ sender: BaseButton) {
        leadingButtonTappedCallback?()
    }
    
    @IBAction func trailingButtonTappedAction(_ sender: BaseButton) {
        /// Default behaviours
        /// if there is any default entry type implementation, then
        switch entryType {
        case .password:
            textfieldIsSecureToggle()
        default:
            trailingButtonTappedCallback?()
        }
    }
}

// MARK: - Handling of States
extension StandardTextField {
    private func changeStateIfNeeded() {
        containerView.backgroundColor = state.backgroundColor
        containerView.layer.borderColor = state.borderColor
        errorLabel.textColor = state.color
        leadingButton.tintColor = AppColor.eAnd_Grey_100
        trailingButton.tintColor = AppColor.eAnd_Grey_100
        titleLabel.textColor = textField.isFirstResponder ? AppColor.eAnd_Grey_100 : AppColor.eAnd_Grey_50
        titleLabel.font = titleLabelFont
        textField.textColor = state.textFieldTextColor
        textField.isHidden = isTextFieldSetHidden
        charactersCountLabel.textColor = state.color
        charactersCountLabel.isHidden = !state.isUserInteractionEnabled && !showCharactersCount
        isUserInteractionEnabled = state.isUserInteractionEnabled
    }
    
    func showSuccess(with message: String) {
        errorLabel.text = message
        state = .success
        textFieldBottomView.isHidden = false
        charactersCountLabel.isHidden = !showCharactersCount
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func showError(with message: String) {
        errorLabel.text = message
        state = .error
        textFieldBottomView.isHidden = false
        charactersCountLabel.isHidden = !showCharactersCount
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func hideError() {
        errorLabel.text = ""
        state = textField.isFirstResponder ? .focus:.normal
        textFieldBottomView.isHidden = true
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Text Field Delegate Methods
extension StandardTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if state != .error {
            state = .normal
        }
        
        textFieldDidEndEditingCallback?()
        changeTitleLabelColorIfNeeded()
        
        if entryType == .phoneNumber && shouldFormatPhoneNumber {
            if CommonMethods.validateUAEMobileNumberWithOutCode(phoneNumber: text) {
                textField.text = CommonMethods.getFormattedPhoneNumberWithOutCode(phoneNumber: text)
            }
        }
        if entryType == .internationalPhoneNumber && shouldFormatPhoneNumber {
            textField.text = CommonMethods.getInternationalMobileNoFormatted(phoneNo: text)
//            if CommonMethods.validateInternationalMobileNo(phoneNumber: text,
//                                                                regex: "^\\+(?:[0-9]?){6,14}[0-9]$") {
//                
//            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if state != .error {
            state = .focus
        }
        textFieldDidBeginEditingCallback?()
        changeTitleLabelColorIfNeeded()
        
        if (entryType == .phoneNumber || entryType == .phoneNumber) && shouldFormatPhoneNumber {
            textField.text = CommonMethods.removeWhiteSpacesFromString(text: text)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Override default behaviour
        if let textFieldShouldChangeCharsInRnage = textFieldShouldChangeCharsInRnage {
            return textFieldShouldChangeCharsInRnage(range, string)
        }
        
        if string.isEmpty && range.length > 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        if range.length + range.location > currentText.count {
            return false
        }
        
        let text = (currentText as NSString).replacingCharacters(in: range, with: string)
        let count = text.count
        
        // Update the character count label
        charactersCountLabel.text = "\(count)/\(charactersLimit)"
        
        
        if entryType == .phoneNumber && shouldFormatPhoneNumber {
            
//            if !text.hasPrefix("5") {
//                return false
//            }
            
            let allowedCharacters = CharacterSet(charactersIn: self.allowedCharacters ?? "")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && text.replace(" ", withString: "").count <= entryType.characterLimit
        }
        
        // Limit the text field to 100 characters
        return count <= charactersLimit
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - String Extension
extension String {
    /**
     Initializes a format function that take Parameters and provide formate string with the provided parts and specifications.
     I m using NSRegularExpression pattern for format.
     - Parameters:
     - phoneNumber : The Number Which you want to formate
     - shouldRemoveLastDigit : (Option Variable) it use some case when you want to remove last string index
        - phoneNumber : The Number Which you want to formate
        - shouldRemoveLastDigit : (Option Variable) it use some case when you want to remove last string index
    
     
     - Returns: A beautiful, brand-new format string , custom-built just for you.
     */
    func cleanedString() ->  String {
        return removeLeadingAndTrailingSpaces()
    }
    
    func removeLeadingAndTrailingSpaces() ->  String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func replace(_ target: String, withString: String) -> String {
        return replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    public func formatFor(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        
        //Check empty string
        guard !phoneNumber.isEmpty else { return "" }
        
        var number = phoneNumber.replace("+971", withString: "").replace("+", withString: "")
        if number.first != "5" {
            number.removeFirst()
        }
        //Check empty string again
        guard !number.isEmpty else { return "" }
        
        // RegularExpression
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: number).range(of: number)
        number = regex.stringByReplacingMatches(in: number, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 9 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 9)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 6 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{2})(\\d+)", with: "$1 $2", options: .regularExpression, range: range)
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{2})(\\d{3})(\\d+)", with: "$1 $2 $3", options: .regularExpression, range: range)
        }
        
        return number
    }
    
    
    /**
     Initializes a new String Object with the provided Information and specifications after then it provider formated String.
     
        - Returns: A beautiful, brand-new format string.
     
     */
    
    public var formattedPhoneNumber: String {
        return formatFor(phoneNumber: cleanedString())
    }

    
    public var planPhoneNumberString: String {
        
        return self
            .replace("+", withString: "")
            .replace(" ", withString: "")
            .replace("-", withString: "")
            .replace("(", withString: "")
            .replace(")", withString: "")
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
