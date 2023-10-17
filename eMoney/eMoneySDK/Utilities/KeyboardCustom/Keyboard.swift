//
//  Keyboard.swift
//  CustomKeyboard
//
//  Created by Muhammad Hassan Shafi on 18/05/2023.
//

import Foundation
import UIKit


protocol KeyboardDelegate: AnyObject {
      func keyWasTapped(character: String)
      func keyCrossTapped()
      func keyScanTapped()
      func currentValuestring(value:String)
}

class Keyboard: UIView {
    
    // This variable will be set as the view controller so that
    // the keyboard can send messages to the view controller.
    @IBOutlet weak var biomatricScanBtn: UIButton!
    weak var target: (UIKeyInput & UITextInput)?
    weak var delegate: KeyboardDelegate?
    var keyboardCurrentInput = String()
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "Keyboard" // xib extention not included
        
        let view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed(xibFileName, owner: self,options: nil)![0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        if (UserDefaultHelper.userBiomatricToken != nil) {
            self.biomatricScanBtn.setImage(UIImage(named: "scanface"), for: .normal)
            self.biomatricScanBtn.isUserInteractionEnabled = true
        }else{
            self.biomatricScanBtn.setImage(nil, for: .normal)
            self.biomatricScanBtn.isUserInteractionEnabled = false
        }
    }
    
//    func currentInputValueAdd(str : String){
//        keyboardCurrentInput += str
//        self.delegate?.currentValuestring(value: keyboardCurrentInput)
//    }
//    func currentInputValueLastDrop(){
//        if keyboardCurrentInput.count > 0 {
//            keyboardCurrentInput = String(keyboardCurrentInput.dropLast())
//        }
//        else {
//            keyboardCurrentInput = ""
//        }
//        self.delegate?.currentValuestring(value: keyboardCurrentInput)
//    }
    
    // MARK:- Button actions from .xib file
    @IBAction func keyCrossTapped(_ sender: Any) {
        //currentInputValueLastDrop()
        target?.deleteBackward()
        self.delegate?.keyCrossTapped()
    }
    @IBAction func keyScanTapped(_ sender: Any) {
        self.delegate?.keyScanTapped()
    }
    
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        insertText(sender.titleLabel!.text!)
        self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)// could alternatively send a tag value
    }
    
    func insertText(_ string: String) {
        guard let range = target?.selectedRange else { return }

        if let textField = target as? UITextField, textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) == false {
            return
        }

        target?.insertText(string)
    }
    
}

extension UITextInput {
    var selectedRange: NSRange? {
        guard let textRange = selectedTextRange else { return nil }

        let location = offset(from: beginningOfDocument, to: textRange.start)
        let length = offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}
