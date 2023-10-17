//
//  PinView.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 31/03/2023.
//

import UIKit

enum PinViewType {
    case loginPin
    case otpPin
}

final class PinView: UIView {

    // MARK: - IBOutlets

    @IBOutlet private weak var outerContainerView: UIView!
    @IBOutlet private weak var innerContainerView: UIView!
    @IBOutlet private weak var codeLabel: UILabel!

    @IBOutlet private weak var indicatorView: UIView!

    var viewType: PinViewType = .loginPin {
        didSet{
            outerContainerView.layer.borderWidth = self.viewType == .loginPin ? 0:1
        }
    }
    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitilState()
    }
}

// MARK: - PinContainer

extension PinView: PinContainer {

    public func set(value: String?) {
        codeLabel.text = value
        codeLabel.textColor = AppColor.eAnd_Black_80
        
    }

    public func clear() {
        codeLabel.text = "0"
        codeLabel.textColor = AppColor.eAnd_Grey_50
    }

    public func setupState(isActive: Bool, isError: Bool) {
        if isActive {
            outerContainerView.layer.borderColor = AppColor.pinFieldSelectedColor.cgColor

//            if indicatorView.isHidden {
//                startIndicatorAnimation()
//            }
        } else {
            let color = isError ? AppColor.pinFieldErrorColor : AppColor.pinFieldNormalColor
            outerContainerView.layer.borderColor = color.cgColor
            
           // stopIndicatorAnimation()
        }
    }

}

// MARK: – Configuration

private extension PinView {
    
    func setupInitilState() {
        configureContainerViews()
        configureCodeLabel()
        configureIndicatorView()
    }

    func configureContainerViews() {
        outerContainerView.backgroundColor = .white//UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1.0)
        outerContainerView.layer.cornerRadius = 16
        outerContainerView.layer.masksToBounds = true
        outerContainerView.layer.borderWidth = self.viewType == .loginPin ? 0:1
        outerContainerView.layer.borderColor = AppColor.pinFieldNormalColor.cgColor

        innerContainerView.backgroundColor = .clear
        innerContainerView.layer.cornerRadius = 0
        innerContainerView.layer.masksToBounds = true
    }

    func configureCodeLabel() {
        codeLabel.textColor = AppColor.eAnd_Grey_50
        codeLabel.font = AppFont.appRegular(size: .body2)
        codeLabel.textAlignment = .center
        codeLabel.text = "0"
    }
    
    func configureIndicatorView() {
        indicatorView.backgroundColor = AppColor.pinFieldSelectedColor
        indicatorView.layer.cornerRadius = 1
        indicatorView.isHidden = true
    }

}

// MARK: - Animation

private extension PinView {

    func startIndicatorAnimation() {
        let appearAnimation = CABasicAnimation(keyPath: "opacity")
        appearAnimation.fromValue = 0.0
        appearAnimation.toValue = 1.0
        appearAnimation.duration = 0.5
        appearAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)

        let disappearAnimation = CABasicAnimation(keyPath: "opacity")
        disappearAnimation.fromValue = 1.0
        disappearAnimation.toValue = 0.0
        disappearAnimation.duration = 0.5
        disappearAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [appearAnimation, disappearAnimation]
        animationGroup.duration = 1
        animationGroup.repeatCount = .infinity

        indicatorView.isHidden = false
        indicatorView.layer.add(animationGroup, forKey: "fade")
    }

    func stopIndicatorAnimation() {
        indicatorView.isHidden = true
        indicatorView.layer.removeAllAnimations()
    }

}
