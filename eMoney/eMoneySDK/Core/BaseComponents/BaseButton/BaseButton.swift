//
//  BaseButton.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 31/03/2023.
//

import UIKit

enum BaseButtonType: String {
    
    case Default                = "default"
    case GradientButton         = "gradient"
    case GradientCircleButton   = "gradient_circle"
    case PlainButton            = "plain"
    case BorderButton           = "border"
    case imageTitle             = "gradient_img_title"
}

//protocol ShadowDesignable {
//    var shadowRadius: CGFloat {get set}
//    var shadowOpacity: Float {get set}
//    var shadowOffset: CGSize {get set}
//    var shadowColor: UIColor {get set}
//
//}

@IBDesignable public class BaseButton: UIButton {
    
    private var gradientLayer : CAGradientLayer?
    private var isLayerAdded  : Bool = false
    
//    public var receivesColorFromSDK: Bool = false
//    public var sdkColor = UIColor.green
    
    //Add another stored property which will only be accessible in IB (because the "unavailable" attribute prevents its use in code)
//    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ButtonType: String? {
        willSet {
            // Ensure user enters a valid shape while making it lowercase.
            // Ignore input if not valid.
            if let buttonType = BaseButtonType(rawValue: newValue?.lowercased() ?? "") {
                type = buttonType
            }
        }
    }
    @IBInspectable var height: Int = 48 {
        willSet {
            buttonHeight = newValue
        }
    }
    
    @IBInspectable var isSmall: Bool = false {
        didSet{
            commonInit()
        }
    }
    
    var type:BaseButtonType = .Default // default Widget
    
    var buttonHeight:Int = 48
    // MARK: - Initilizer
    
    public convenience init (frameRect: CGRect) {
        self.init(frame: frameRect)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: Lift Cycle Methods(s)
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        //applyWidgetProperties()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        applyWidgetProperties()
    }
    
    // MARK: Instance Methods
    
    private func commonInit() {
        //registerTapGenterRecognizer()
        if isSmall {
            titleLabel?.font = AppFont.appSemiBold(size: .body4)
        }else{
            titleLabel?.font = AppFont.appSemiBold(size: .body2)
        }
        
    }
    
    //    func registerTapGenterRecognizer() {
    //        self.addTarget(self, action: #selector(handleTap), for: .touchDown)
    //    }
    //
    //    @objc func handleTap() {
    //        ApplicationSessionManager.shared.userIntracted()
    //    }
    
}

extension BaseButton {
    
    /// This method will apply all the properties of Widget
    func applyWidgetProperties() {
        self.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)).isActive = true
        switch type {
        case .GradientButton:
            //if self.gradientLayer == nil && isLayerAdded == false {
            layoutGradientButtonLayer()
            //}
            
        case .PlainButton:
            setupPlainButton()
            
        case .BorderButton:
            setupBorderButton()
        case .GradientCircleButton:
            setupGradientCircleImageButton()
        case .imageTitle:
            setupImageTitleButton()
            
        default:
            break
        }
    }
    
    // MARK: Private
    private func layoutGradientButtonLayer() {
        
        addGradient()
        setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    private func setupBorderButton() {
        //setTitleColor(AppColor.eAnd_gray, for: UIControl.State.disabled)
        setTitleColor(AppColor.eAnd_Red, for: UIControl.State.normal)
        
        backgroundColor = UIColor.clear
        
        self.gradientBorder(width: 1, colors: [AppColor.baseButtonGradiant1,AppColor.baseButtonGradiant2], startPoint: .unitCoordinate(.bottomLeft), endPoint: .unitCoordinate(.topRight), andRoundCornersWithRadius: CGFloat(self.buttonHeight/2))
        
    }
    
    private func setColorFromOr(color: UIColor) {
        if let color = SDKColors.shared.receivedTheme?.buttonTextColor {
            setTitleColor(UIColor(hex: color), for: UIControl.State.normal)
        } else {
            setTitleColor(color, for: UIControl.State.normal)
        }
    }
    
    private func setupPlainButton() {
        
        //setTitleColor(Constants.ColorConstants.disabledButtonTextColor, for: UIControl.State.disabled)
//        setTitleColor(AppColor.eAnd_Red, for: UIControl.State.normal)
        
        self.setColorFromOr(color: AppColor.eAnd_Red)
    }
    
    private func setupImageTitleButton() {
        
        //setTitleColor(Constants.ColorConstants.disabledButtonTextColor, for: UIControl.State.disabled)
        if LocaleManager.isRTLLanguage() {
            imageEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
            titleEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
        }else{
            imageEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 10)
            titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        }

        
        addGradient()
//        setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.setColorFromOr(color: .white)
        titleLabel?.font = AppFont.appSemiBold(size: .body2)
    }
    
    private func setupGradientCircleImageButton() {
        self.widthAnchor.constraint(equalToConstant: CGFloat(buttonHeight)).isActive = true
        
        addGradient()
//        setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.setColorFromOr(color: .white)
        titleLabel?.font = AppFont.appSemiBold(size: .body2)
    }
    
    func addGradient(){
        let gradient            = gradientLayer ?? CAGradientLayer()
        gradient.frame          = self.bounds //CGRect(x: 0, y: 0, width: 320, height: 54)
        if LocaleManager.isRTLLanguage() {
            gradient.colors = [
                AppColor.baseButtonGradiant2.cgColor,
                AppColor.baseButtonGradiant1.cgColor
            ]
        }else{
            gradient.colors = [
                AppColor.baseButtonGradiant1.cgColor,
                AppColor.baseButtonGradiant2.cgColor
            ]
        }
        //gradient.locations      = [0, 1]
        gradient.startPoint     = CGPoint(x: 0, y: 0.8)
        gradient.endPoint       = CGPoint(x: 1, y: 0.2)
        gradient.cornerRadius   = CGFloat(self.buttonHeight/2)
        layer.cornerRadius      = CGFloat(self.buttonHeight/2)
        if let color = SDKColors.shared.receivedTheme?.buttonBackgroundColor {
            self.backgroundColor = UIColor(hex: color)
        } else {
            layer.insertSublayer(gradient, at: 0)
            gradientLayer           = gradient
            isLayerAdded            = true
        }
    }
    
    func enable() {
        
        isEnabled   = true
        alpha = 1
        isUserInteractionEnabled = true
        
    }
    
    func disable() {
        isEnabled   = false
        alpha = 0.3
        isUserInteractionEnabled = false
    }
    
    //    func setSelected(_ value: Bool) {
    //        if widget == BaseButtonType.Circle {
    //            if value {
    //                backgroundColor = UIColor.white.withAlphaComponent(0.3)
    //            }
    //            else {
    //                self.backgroundColor = UIColor.clear
    //            }
    //        }
    //        isSelected = value
    //    }
    
    
}


//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowColor: UIColor {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return UIColor.clear
//        }
//        set {
//            layer.shadowColor = newValue.cgColor
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor = UIColor.white {
//        didSet {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat = 2.0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//
//    @IBInspectable var cornerRadius: CGFloat = 0.0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//        }
//    }
