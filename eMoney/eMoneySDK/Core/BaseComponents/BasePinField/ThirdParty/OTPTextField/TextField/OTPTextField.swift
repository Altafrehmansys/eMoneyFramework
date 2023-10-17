//
//  OTPTextField.swift
//  OTPTextFieldExample
//
//  Created by Vladislav Krupenko on 19.03.2020.
//  Copyright © 2020 Fixique. All rights reserved.
//

import UIKit

/// Class for create custom OTPTextField with ability for enter otp characters and callback when otp enter
public final class OTPTextField: BaseInputView {

    // MARK: - Public Properties
    

    public var onBeginEditing: (() -> Void)?
    public var onTextChanged: ((String?) -> Void)?
    public var onEndEditing: (() -> Void)?
    public var onOTPEnter: ((String) -> Void)?

    override public var inputView: UIView? {
        get { return innerInputView }
        set { innerInputView = newValue }
    }

    override public var inputAccessoryView: UIView? {
        get { return innerInputAccessoryView }
        set { innerInputAccessoryView = newValue }
    }

    override public var canBecomeFirstResponder: Bool {
        return true
    }

    // MARK: - Private Properties

    private var configuration: OTPFieldConfiguration = OTPFieldConfiguration(adapter: DefaultTextFieldAdapter()) {
        didSet {
            updateUI()
        }
    }
    private var keyboardType: UIKeyboardType = .numberPad
    private var keyboardAppearance: UIKeyboardAppearance = .light
    private var autocorrectionType: UITextAutocorrectionType = .no
    private var allowedCharactersSet: CharacterSet = .alphanumerics
    private var isInputEnabled: Bool = true

    private var innerInputView: UIView?
    private var innerInputAccessoryView: UIView?
    private var charactersCount: Int {
        return configuration.adapter.numberOfPins()
    }
    private var pinViews: [PinContainer] = []
    private var text: String?
    private var currentCharactersCount: Int {
        return text?.count ?? 0
    }
    private var isError = false

    private var mainView: UIView = UIView()
    
    // MARK: - Initialization

    override public init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateUI()
    }

    // MARK: - UIView

    override public func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        configureInputPinViews()
    }

    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        onBeginEditing?()
        manageIndicatorOnBecomeResponder()
        self.updateBorderOnMainField(isActive: true, isError: isError)
        return super.becomeFirstResponder()
    }

    @discardableResult
    override public func resignFirstResponder() -> Bool {
        onEndEditing?()
        pinViews.forEach { $0.setupState(isActive: false, isError: isError) }
        self.updateBorderOnMainField(isActive: false, isError: isError)
        return super.resignFirstResponder()
    }

    // MARK: - BaseInputView

    override public var hasText: Bool {
        return text?.isEmpty == false
    }

    override public func insertText(_ character: String) {
        insertCharacters(character)
    }

    override public func deleteBackward() {
        guard hasText, isInputEnabled else {
            return
        }
        pinViews[safe: currentCharactersCount - 1]?.clear()
        pinViews[safe: currentCharactersCount - 1]?.setupState(isActive: true, isError: isError)
        pinViews[safe: currentCharactersCount]?.setupState(isActive: false, isError: isError)
        text?.removeLast()
        notifyIfTextChanged()
    }

    // MARK: - Touches

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        guard bounds.contains(location) else {
            return
        }
        becomeFirstResponder()
    }

    // MARK: - Public Methods

    /// Method will set configuration for field and update field appearance
    public func setConfiguration(_ configuration: OTPFieldConfiguration) {
        self.configuration = configuration
    }

    /// Method will disable input by keyboard and setText method
    public func setEnabled(_ enabled: Bool) {
        isInputEnabled = enabled
    }

    /// Method will set text by one character per pin view
    public func setText(_ text: String) {
        insertCharacters(text)
    }

    /// Method will affect all pin views and set error state
    public func setError() {
        isError = true
        let activeIndex = isFirstResponder ? currentCharactersCount : nil
        for (index, pin) in pinViews.enumerated() {
            pin.setupState(isActive: index == activeIndex, isError: isError)
        }
        self.updateBorderOnMainField(isActive: false, isError: isError)
    }

    /// Method will affect all pin views and remove state
    public func removeError() {
        guard isError else {
            return
        }
        isError = false
        let activeIndex = isFirstResponder ? currentCharactersCount : nil
        for (index, pin) in pinViews.enumerated() {
            pin.setupState(isActive: index == activeIndex, isError: isError)
        }
        self.updateBorderOnMainField(isActive: true, isError: isError)
    }

    /// Method will clear text field
    public func clear() {
        text = nil
        notifyIfTextChanged()
        updateUI()
    }
    

}

// MARK: - Configuration

private extension OTPTextField {

    /// Method rebuild all pinField views
    func updateUI() {
        applyConfiguraion()
        loadPinViews()
        configureInputPinViews()
    }

    /// Method apply current configuration for viewl
    func applyConfiguraion() {
        keyboardType = configuration.keyboardType
        keyboardAppearance = configuration.keyboardAppearance
        autocorrectionType = configuration.autocorrectionType
        allowedCharactersSet = configuration.allowedCharactersSet
    }

    /// Method remove from superview old instance of pinviews and reload all pins with new configuration
    func loadPinViews() {
        pinViews.forEach { $0.view.removeFromSuperview() }
        pinViews.removeAll()
        for index in 0..<charactersCount {
            let pinView = configuration.adapter.otpTextField(viewAt: index)
            pinViews.append(pinView)
        }
    }

    /// Method will add and position new views
    func configureInputPinViews() {
//        var xPinPosition: CGFloat = 0
//        for (index, item) in pinViews.enumerated() {
//            let size = configuration.adapter.otpTextField(sizeForViewAt: index)
//            item.view.frame = CGRect(x: xPinPosition, y: 0, width: size.width, height: size.height)
//            addSubview(item.view)
//            xPinPosition += size.width + configuration.adapter.otpTextField(spaceForViewAt: index)
//        }
        
        let leadingPadding:CGFloat = 16
        let tralingPadding:CGFloat = 16
        
        mainView = UIView()
        mainView.tag = 1001
        //mainView.backgroundColor = .red
        self.updateBorderOnMainField(isActive: false, isError: isError)
        
        let pinStackView = UIStackView()
        pinStackView.tag = 1002
        pinStackView.axis  = .horizontal
        pinStackView.alignment = .center
        pinStackView.distribution  = .fill
        pinStackView.spacing = configuration.adapter.spaceBetweenViews()
        
        for (index, item) in pinViews.enumerated() {
            let size = configuration.adapter.otpTextField(sizeForViewAt: index)
            item.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            item.view.heightAnchor.constraint(equalToConstant: size.height).isActive = true
            item.view.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            pinStackView.addArrangedSubview(item.view)
            
            if configuration.adapter.showSeperatorBetweenFields() {
                if index < (pinViews.count-1){
                    let seperatorView = UIView()
                    seperatorView.backgroundColor = AppColor.eAnd_Grey_20
                    seperatorView.heightAnchor.constraint(equalToConstant: 24).isActive = true
                    seperatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
                    pinStackView.addArrangedSubview(seperatorView)
                }
            }
        }
        // using auto-layout
        pinStackView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(pinStackView)
        
        if let viewWithTag = self.viewWithTag(1001) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = self.viewWithTag(1002) {
            viewWithTag.removeFromSuperview()
        }
        
        addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0),
//            mainView.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
//            mainView.heightAnchor.constraint(equalToConstant: self.bounds.size.height),
            
            pinStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0),
            pinStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
            pinStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: leadingPadding),
            pinStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -tralingPadding)
                    ])
    }

    private func updateBorderOnMainField(isActive: Bool, isError: Bool){
        if configuration.adapter.showBorderOnMainView() {
            mainView.layer.borderWidth = 1
            mainView.layer.cornerRadius = 16
            if isActive {
                mainView.layer.borderColor = AppColor.pinFieldSelectedColor.cgColor
            } else {
                let color = isError ? AppColor.pinFieldErrorColor : AppColor.pinFieldNormalColor
                mainView.layer.borderColor = color.cgColor
            }
        }
    }
}

// MARK: - Help Methods

private extension OTPTextField {

    /// Method return true, if character fits current lenght, character set and input is enabled
    func canInsertCharacter(_ character: String) -> Bool {
        let newText = text.map { $0 + character } ?? character
        let isCharacterMatchingSet = character.trimmingCharacters(in: allowedCharactersSet).isEmpty
        let isCorrectLength = newText.count <= charactersCount
        return !character.isEmpty && isCharacterMatchingSet && isCorrectLength && isInputEnabled
    }

    /// Method check if we can insert characters
    /// if more than one character will fill all pins
    /// if one character will set in first empty pin view
    func insertCharacters(_ characters: String) {
        guard canInsertCharacter(characters) else {
            return
        }
        if characters.count > 1 {
            pinViews.forEach { $0.setupState(isActive: false, isError: isError) }
            for (index, char) in characters.enumerated() {
                pinViews[safe: index]?.set(value: String(char))
            }
            text = characters
        } else {
            text = text.map { $0 + characters } ?? characters
            pinViews[safe: currentCharactersCount - 1]?.setupState(isActive: false, isError: isError)
            pinViews[safe: currentCharactersCount - 1]?.set(value: characters)
            pinViews[safe: currentCharactersCount]?.setupState(isActive: true, isError: isError)
        }
        notifyIfTextChanged()
    }

    /// Method will triggered if all pins filled
    func notifyIfTextChanged() {
        onTextChanged?(text)
        guard currentCharactersCount == charactersCount else {
            return
        }
        onOTPEnter?(text ?? "")
    }

    /// Method will animate indicator on current empty pin view
    func manageIndicatorOnBecomeResponder() {
        guard let text = text else {
            pinViews[safe: 0]?.setupState(isActive: true, isError: isError)
            return
        }
        pinViews[safe: text.count]?.setupState(isActive: true, isError: isError)
    }

}
