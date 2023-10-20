//
//  TopViewController.swift
//  PodsTester
//
//  Created by Saud Waqar on 12/09/2023.
//

import UIKit

class TopViewController: SDKBaseViewController {
    
    //MARK:- Child indicator view at the top
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var imgTopCenter: UIImageView!
    @IBOutlet weak var lblTopCenter: UILabel!
    
    var delegate: TopViewActionsSDK?
    var floDelegate: SendDataSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addActions()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        if let color = SDKColors.shared.receivedTheme?.toolBarIconColor {
            self.crossButton.tintColor = color//UIColor(hex: color)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.floDelegate?.sendStringData(string: "me")
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            self.delegate?.actionSwipeUp()
        } else if gesture.direction == .down {
            self.delegate?.actionSwipeDown()
        }
    }
    
    func setupTopView(isFirst: Bool, _ lblTitle: String) {
        DispatchQueue.main.async {
//            self.backButton.isHidden   = isFirst ? true  : false
            self.backButton.isHidden   = true
            self.imgTopCenter.isHidden = isFirst ? false : true
            self.lblTopCenter.isHidden = true
            self.crossButton.isHidden  = false
//            self.lblTopCenter.isHidden = isFirst ? true  : false
//            self.lblTopCenter.text     = "Register"
        }
    }
    
    private func addActions() {
        self.backButton.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        self.crossButton.addTarget(self, action: #selector(actionCross), for: .touchUpInside)
    }
    
    @objc private func actionBack() {
        self.delegate?.actionBack()
    }
    
    @objc private func actionCross() {
        self.delegate?.actionCross()
    }
}
