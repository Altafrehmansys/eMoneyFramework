//
//  UILabelExtension.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 18/04/2023.
//

import UIKit

public protocol TypographyExtensions: UILabel {
    var lineHeight: CGFloat? { get set }
}

class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}

extension UILabel: TypographyExtensions {
    
    public var lineHeight: CGFloat? {
        get { nil }
        set {
            // Values.
            let lineHeight = newValue ?? font.lineHeight
            let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
            
            // Paragraph style.
            let mutableParagraphStyle = NSMutableParagraphStyle()
            mutableParagraphStyle.minimumLineHeight = lineHeight
            mutableParagraphStyle.maximumLineHeight = lineHeight
            
            // Set.
            attributedText = NSAttributedString(
                string: text ?? "",
                attributes: [
                    .baselineOffset : baselineOffset,
                    .paragraphStyle : mutableParagraphStyle
                ]
            )
        }
    }
}

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        guard let text = self.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineHeight
        attributeString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
}
// MARK: - Set Color for specific part of text in UILabel
extension UILabel {
    func set(text: String, withColorPart colorTextPart: String, color: UIColor) {
        attributedText = nil
        let result =  NSMutableAttributedString(string: text)
        result.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSString(string: text.lowercased()).range(of: colorTextPart.lowercased()))
        attributedText = result
    }
}
