//
//  BaseAmountField.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 06/04/2023.
//

import UIKit

enum AmountFieldType {
    case error
    case success
    case disable
    case enable
}

class BaseAmountField: UIView {
    var view:UIView!
    var fieldTypeEnum = AmountFieldType.error
    @IBOutlet weak var stackViewTop: UIStackView!
    @IBOutlet private weak var textFieldAmount: UITextField! {
        didSet {
            textFieldAmount.keyboardType = .asciiCapableNumberPad
        }
    }
    @IBOutlet weak var labelDescription: UILabel!
    var errorColor = AppColor.eAnd_Error_100
    var successColor = AppColor.greenSuccessHex
    var disableColor = AppColor.disableAmountFieldColor
    var enableColor = AppColor.enableAmountFieldColor
    var currentColor = AppColor.greenSuccessHex
    var amount:String? {
        return String(textFieldAmount.text?.components(separatedBy: " ").last ?? "0.0")
    }
    
    private var currency = Strings.Generic.currency
    
    
    // MARK: - Public Properties
    var textfieldFonts = [AppFont.appSemiBold(size: .h5), AppFont.appRegular(size: .h6)]
    var textChangedCallback: (() -> Void)?
    var becomeFirstResponder: Bool {
        get { return textFieldAmount.isFirstResponder }
        set {
            if newValue == true {
                textFieldAmount.becomeFirstResponder()
            } else {
                textFieldAmount.resignFirstResponder()
            }
        }
    }
    
    var text: String? {
        get { textFieldAmount.text }
        set {
            textFieldAmount.text = newValue
            setAttribute(text: newValue ?? "")
        }
    }
    var textColor: UIColor? {
        get { textFieldAmount.textColor }
        set {
            textFieldAmount.textColor = newValue
            setAttribute(text: self.textFieldAmount.text ?? "")
        }
    }
    
    private var limit = 6
    
    /// set the limit for input numbers
    var charactersLimit: Int {
        get {
            return limit
        }
        set {
            limit = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

    }
    
    private func commonInit() {
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("BaseAmountField", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func textFieldStateManage(descText : String , color : UIColor , isEnable : Bool){
        self.textFieldAmount.isUserInteractionEnabled = isEnable
        currentColor = color
        self.textFieldAmount.textColor = currentColor
        self.labelDescription.textColor = currentColor
        self.labelDescription.text = descText
    }
    
    func setState(desc : String,fieldType : AmountFieldType){
      
        switch fieldType {
        case .error:
            textFieldStateManage(descText: desc, color: errorColor, isEnable: true)
        case .success:
            textFieldStateManage(descText: desc, color: successColor, isEnable: true)
        case .disable:
            textFieldStateManage(descText: desc, color: disableColor, isEnable: false)
        case .enable:
            textFieldStateManage(descText: desc, color: enableColor, isEnable: true)
        }
    }
    
    func setError(desc : String){
        textFieldStateManage(descText: desc, color: errorColor, isEnable: true)
    }
    func setSuccess(desc : String){
        textFieldStateManage(descText: desc, color: successColor, isEnable: true)
    }
    func setDisable(desc : String){
        textFieldStateManage(descText: desc, color: disableColor, isEnable: false)
    }
    func setEnable(desc : String){
        textFieldStateManage(descText: desc, color: enableColor, isEnable: true)
    }
    
    func settingView(desc : String){
        labelDescription.text = desc
        if desc.isEmpty {
            labelDescription.isHidden = true
        }
        textFieldAmount.delegate = self
        textFieldAmount.keyboardType = .decimalPad
    }
    
    private func setAttribute(text: String) {
        
        var text = text
        
        if !text.contains(currency) {
            text = self.currency + " " + text
        }
 
        let mutableAttributedString = NSMutableAttributedString.init(string: text)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: currentColor, range: NSRange(location: 0, length: text.count))
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: textfieldFonts[0], range: NSRange(location: 0, length: text.count))
        
        let range = (text as NSString).range(of: self.currency)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: currentColor, range: range)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: textfieldFonts[1], range: range)
        textFieldAmount.attributedText = mutableAttributedString
    }
    
    @IBAction func textFieldChange(_ sender: UITextField) {
        self.textChangedCallback?()
        setAttribute(text: sender.text ?? "")
    }
}

extension BaseAmountField : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let isBackspacePressed = string.count == 0 && range.length > 0
        
        if range.length + range.location > currentText.count {
            return false
        }
        let text = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField.text == "AED " && isBackspacePressed {
            return false
        }
        
        guard CharacterSet(charactersIn: "0123456789.").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        
        if isBackspacePressed {
            // Back pressed
            return true
        }
        
        let amountText = text.replace(string: currency + " ", replacement: "")
        
        if amountText.count > self.limit {
            return false
        }
        
        if !self.validateAmountField(newText: amountText) {
            return false
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text?.replace(string: (currency + " "), replacement: "")
        if let amount = Double(text ?? ""), amount > 0 {
            self.setAttribute(text: String(format: "%.2f", amount))
        }
    }
    
    func validateAmountField(newText:String) -> Bool {
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
