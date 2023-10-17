//
//  BaseTooltipViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 10/04/2023.
//

import UIKit
protocol tooltipActionProtocol {
    func buttonLeftTapped()
    func buttonRightTapped()
    func buttonCrossTapped()
}

class BaseTooltipViewController: UIViewController {
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    var alertTitle = ""
    var alertMessage = ""
    var okButtonTitle = "Ok"
    var cancelButtonTitle = "Cancel"
    var backgroundColor = AppColor.toolTipSuccessColor
    var delegate : tooltipActionProtocol?
    private var gradientLayer : CAGradientLayer?
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var buttonCross: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAlert()
    }
    func setupAlert() {
        lblTitle.text = alertTitle
        lblDesc.text = alertMessage
        self.buttonLeft.setTitle(okButtonTitle, for: .normal)
        self.buttonRight.setTitle(cancelButtonTitle, for: .normal)
        self.viewContent.backgroundColor = backgroundColor
        viewContent.layer.cornerRadius = 10
        layoutGradientButtonLayer()
        
    }
    private func layoutGradientButtonLayer() {
        
        let gradient            = gradientLayer ?? CAGradientLayer()
        gradient.frame          = self.buttonRight.bounds //CGRect(x: 0, y: 0, width: 320, height: 54)
        gradient.colors = [
            AppColor.baseButtonGradiant1.cgColor,
            AppColor.baseButtonGradiant2.cgColor
        ]
        //gradient.locations      = [0, 1]
        gradient.startPoint     = CGPoint(x: 0, y: 0.8)
        gradient.endPoint       = CGPoint(x: 1, y: 0.2)
        gradient.cornerRadius   = CGFloat(self.buttonRight.frame.height/2)
        buttonRight.layer.cornerRadius      = CGFloat(self.buttonRight.frame.height/2)
        buttonRight.layer.insertSublayer(gradient, at: 0)
        gradientLayer           = gradient
        buttonRight.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }

    init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        super.init(nibName: "BaseTooltipViewController", bundle: bundle)
        //Bundle(for: BaseTooltipViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func show() {
        if #available(iOS 13, *) {
            UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController!.present(self, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonLeftTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.buttonLeftTapped()
    }
    
    @IBAction func buttonRightTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.buttonRightTapped()
    }
    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.buttonCrossTapped()
    }
    
}
