//
//  IMTAmountTextField.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 05/06/2023.
//

import UIKit

@IBDesignable
final class IMTAmountTextField: UIView {
    enum `EntryType`: Equatable {
        case text
        case decimal
        case numberPad
    }
    
    enum States {
        case error
        case disabled
        case success
        case normal
        case focus
        
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
                return AppColor.eAnd_Grey_50.cgColor
            case .focus:
                return AppColor.eAnd_Black_80.cgColor
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
            containerView.layer.borderWidth = 1
            containerView.layer.cornerRadius = cornerRadiusTextField
        }
    }
    @IBOutlet private weak var charactersCountLabel: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var leadingButton: BaseButton!
    @IBOutlet weak var leadingDropDownButton: BaseButton!
    @IBOutlet private weak var leadingButtonImageView: UIImageView!
    @IBOutlet private weak var leadingButtonLabel: UILabel!
    //@IBOutlet private weak var trailingButtonImageView: UIImageView!
    @IBOutlet private weak var leadingStackView: UIStackView!
   // @IBOutlet private weak var trailingStackView: UIStackView!
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
    private lazy var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(IMTAmountTextField.tapGestureRecognized(_:)))
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
                self.leadingButtonImageView.image = UIImage(named: leadingButtonImage)
            }
        }
    }
    var leadingLabel: String? {
        didSet {
            if let leadingLabel {
                self.leadingButtonLabel.text = leadingLabel
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
extension IMTAmountTextField {
    
    func setupConfigurations() {
        
        titleLabel.font = titleLabelFont
        textField.textColor = textFieldTextColor
        if let attributedText = textField.attributedText, attributedText.string.isEmpty {
            textField.font = textFieldFont
        }
        
        //setPlaceholderText()
        
        errorLabel.font = AppFont.appRegular(size: .body4)
        charactersCountLabel.font = AppFont.appRegular(size: .body4)
        charactersCountLabel.text = "\(text.count)/\(charactersLimit)"
        leadingButtonLabel.font = AppFont.appSemiBold(size: .body2)
        leadingButtonLabel.textColor = AppColor.eAnd_Black_80
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
            textField.addTarget(self, action: #selector(IMTAmountTextField.textFieldTextDidChange(_:)), for: UIControl.Event.editingChanged)
            
            self.setupConfigurations()
            
            addGestureRecognizer(tapGestureRecognizer)
        }
        
        view.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func loadViewFromNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        let nib = UINib(nibName: String(describing: IMTAmountTextField.self), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    private func setPlaceholderText() {
        
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
    
    private func setAttributedPlaceHolder(_ string: String) {
        textField.attributedPlaceholder = NSAttributedString(string: string)
        if let placeHolderLabel = textField.value(forKey: "placeholderLabel") as? UILabel {
            placeHolderLabel.minimumScaleFactor = 0.5
            placeHolderLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    private func setupTextFieldOnTypeChanges() {
        switch entryType {
            
        case .decimal:
            allowedCharacters = decimalsOnlyString
            textField.keyboardType = .decimalPad
            
        case .text:
            textField.keyboardType = .default
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.inputView = nil
            textField.inputAccessoryView = nil
        case .numberPad:
            textField.keyboardType = .numberPad
        }
    }
    
    private func changeTitleLabelColorIfNeeded(withAnimation: Bool = true) {
        containerView.layer.borderColor = state.borderColor
        titleLabel.textColor = textField.isFirstResponder ? AppColor.eAnd_Grey_100 : AppColor.eAnd_Grey_50
        
        UIView.animate(withDuration: withAnimation ? 0.2 : 0) {
            self.textField.alpha = self.isTextFieldSetHidden ? 0 : 1
            self.textField.isHidden = self.isTextFieldSetHidden
            self.titleLabel.font = self.titleLabelFont
        }
    }
    
}

// MARK: - Actions
extension IMTAmountTextField {
    @objc private func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
    
    @objc private func textFieldTextDidChange(_ textField: UITextField) {
        textChangedCallback?()
    }
    
    @IBAction func leadingButtonTappedAction(_ sender: BaseButton) {
        leadingButtonTappedCallback?()
    }
}

// MARK: - Handling of States
extension IMTAmountTextField {
    private func changeStateIfNeeded() {
        containerView.backgroundColor = state.backgroundColor
        containerView.layer.borderColor = state.borderColor
        errorLabel.textColor = state.color
        leadingButton.tintColor = AppColor.eAnd_Grey_100
        titleLabel.textColor = textField.isFirstResponder ? AppColor.eAnd_Grey_100 : AppColor.eAnd_Grey_50
        titleLabel.font = titleLabelFont
        textField.textColor = state.textFieldTextColor
        textField.isHidden = isTextFieldSetHidden
        charactersCountLabel.textColor = state.color
        charactersCountLabel.isHidden = !showCharactersCount//!state.isUserInteractionEnabled && !showCharactersCount
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
        state = .normal
        textFieldBottomView.isHidden = true
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - Text Field Delegate Methods
extension IMTAmountTextField: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        hideError()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        state = .normal
        textFieldDidEndEditingCallback?()
        changeTitleLabelColorIfNeeded()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        state = .focus
        textFieldDidBeginEditingCallback?()
        changeTitleLabelColorIfNeeded()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Override default behaviour
        if let textFieldShouldChangeCharsInRnage = textFieldShouldChangeCharsInRnage {
            return textFieldShouldChangeCharsInRnage(range, string)
        }
        
        let currentText = textField.text ?? ""
        if range.length + range.location > currentText.count {
            return false
        }
        
        let text = (currentText as NSString).replacingCharacters(in: range, with: string)
        let count = text.count
        
        // Update the character count label
        charactersCountLabel.text = "\(count)/\(charactersLimit)"
        
        if string.count == 0 && range.length > 0 {
            // Back pressed
            return true
        }
        
        if !validateAmountField(newText: text) {
            return false
        }
        
        // Limit the text field to 100 characters
        return count <= charactersLimit
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func validateAmountField(newText:String) -> Bool{
        if Double(newText) ?? 0.0 < 1 {
            return false
        }
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
}

