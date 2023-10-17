//
//  BaseSlider.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 03/04/2023.
//

import UIKit

protocol sliderProtocol {
    func sliderIsCompleted()
}


class BaseSlider: UIView {

    var view:UIView!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var lblSwipeToConfirm: UILabel!
    
    @IBOutlet weak var imageViewArrow: UIImageView!
    var delegate : sliderProtocol?
    private var gradientLayer : CAGradientLayer?
    private var isLayerAdded  : Bool = false
    
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
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("BaseSlider", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        setupView()
        setupGradient()
        //disable()
        
    }
    func enable(){
        self.contentsView.backgroundColor = .clear
        self.contentsView.layer.cornerRadius      = CGFloat(self.view.frame.height/2)
        self.imageViewArrow.image = UIImage(named:"sliderArrow")
        self.isUserInteractionEnabled = true
        
    }
    func disable(){
        self.contentsView.backgroundColor = AppColor.disableSliderHex
        self.contentsView.layer.cornerRadius      = CGFloat(self.view.frame.height/2)
        self.imageViewArrow.image = UIImage(named:"sliderDisableButton")
        self.isUserInteractionEnabled = false
    }
    private func setupView() {

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched(_:)))
        imageViewArrow.addGestureRecognizer(gestureRecognizer)
        imageViewArrow.isUserInteractionEnabled = true
        self.isUserInteractionEnabled = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupGradient() {
       
        let gradient            = gradientLayer ?? CAGradientLayer()
        gradient.frame          = self.bounds //CGRect(x: 0, y: 0, width: 320, height: 54)
        gradient.colors = [
            AppColor.baseButtonGradiant1.cgColor,
            AppColor.baseButtonGradiant2.cgColor
        ]
       
        //gradient.locations      = [0, 1]
        gradient.startPoint     = CGPoint(x: 0, y: 0.8)
        gradient.endPoint       = CGPoint(x: 1, y: 0.2)
        gradient.cornerRadius   = CGFloat(self.view.frame.height/2)
        view.layer.cornerRadius      = CGFloat(self.view.frame.height/2)
        view.layer.insertSublayer(gradient, at: 0)
        gradientLayer           = gradient
        isLayerAdded            = true
    }
    
    
    @objc private func touched(_ gestureRecognizer: UIGestureRecognizer) {
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .changed {
                let locationInView = gestureRecognizer.location(in: touchedView)
                
                var newPos = touchedView.frame.origin.x + locationInView.x
                
                if newPos < 10 {
                    newPos = 10
                } else if newPos > 300 {
                    newPos = 300
                }
                
                touchedView.frame.origin.x = newPos
                
                let diff = 100.0 - touchedView.frame.origin.x
                lblSwipeToConfirm.alpha = diff / 100
                
            } else if gestureRecognizer.state == .ended {
                if touchedView.frame.origin.x > 150 {
                    imageViewArrow.alpha = 0
                    lblSwipeToConfirm.text = "Confirming.."
                    delegate?.sliderIsCompleted()
                    lblSwipeToConfirm.alpha = 1
                } else {
                    
                        touchedView.frame.origin.x = 4
                        lblSwipeToConfirm.alpha = 1
                    
                }
            }
        }
    }
    
}


