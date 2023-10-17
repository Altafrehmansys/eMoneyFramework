//
//  BaseStepper.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/04/2023.
//

import UIKit

class BaseStepper: UIView {
    var view:UIView!
    @IBOutlet weak var labelSteps: UILabel!
    @IBOutlet weak var stackViewSteps: UIStackView!
    private var gradientLayer : CAGradientLayer?
    var currentStep = Int()
    
   
    
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
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("BaseStepper", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .clear
        self.addSubview(view)
        

    }
    
    func addGrayView() -> UIView{
        let myView = UIView()
        myView.layer.cornerRadius = myView.frame.height / 2
        myView.backgroundColor = AppColor.eAnd_Grey_10
        return myView
    }
    func addSelectedView() -> UIView{
        let myView = UIView()
        return myView
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGradient(currentStep: self.currentStep)
    }
    
    func addGradient(currentStep : Int){
        if stackViewSteps.arrangedSubviews.count > 0 {
            print("layout subview called")
            for (index,viewStack) in stackViewSteps.arrangedSubviews.enumerated() {
                
                if index < currentStep {
                    print("layout subview called in loop")
                 self.addGradientView(selectedView: viewStack)
                }else{
                    viewStack.layer.cornerRadius = viewStack.frame.height / 2
                    viewStack.clipsToBounds = true
                }
            }
        }
    }
    
    func addGradientView(selectedView : UIView){
        let gradientLayerName = "StepViewGradient"
        let existingLayer = selectedView.getExistingGradientLayer(layerName:gradientLayerName)
        let gradient = existingLayer ?? CAGradientLayer()
        gradient.name = gradientLayerName
        gradient.frame = selectedView.bounds
        gradient.colors = [
            AppColor.baseButtonGradiant1.cgColor,
            AppColor.baseButtonGradiant2.cgColor
        ]
       
        //gradient.locations      = [0, 1]
        gradient.startPoint     = CGPoint(x: 0, y: 0.8)
        gradient.endPoint       = CGPoint(x: 1, y: 0.2)
        gradient.cornerRadius   = CGFloat(selectedView.frame.height/2)
        gradientLayer = gradient
        selectedView.layer.cornerRadius      = CGFloat(selectedView.frame.height/2)
        
        
        if existingLayer == nil {
            selectedView.layer.insertSublayer(gradient, at: 0)
        }
        
    }
    
    func addRedLine(noOfSteps : Int,currentStep : Int){
        self.currentStep = currentStep
        self.stackViewSteps.removeAllArrangedSubviews()
        stackViewSteps.distribution = .fillEqually
       
        for i in 1 ... noOfSteps  {

            if i <= currentStep {
                let selectedView = addSelectedView()
                
                    self.stackViewSteps.addArrangedSubview(selectedView)
              
            }
            else {
                let grayView = addGrayView()
                stackViewSteps.addArrangedSubview(grayView)
            }
        }
       // stackViewSteps.layoutIfNeeded()
        self.layoutIfNeeded()
        self.setNeedsLayout()
        
        
    }
    
}
extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }
}
