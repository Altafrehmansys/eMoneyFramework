//
//  OneViewController.swift
//  PodsTester
//
//  Created by Saud Waqar on 08/09/2023.
//

import UIKit

class SDKBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSizeMake(20, 20))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}

class OneViewController: UIViewController {
    
    @IBOutlet weak var layoutHeight: NSLayoutConstraint!
    
    var delegate: SendDataSDK?
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.delegate?.sendStringData(string: "\(Self.self)")
        //        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSizeMake(20, 20))
        //        let maskLayer = CAShapeLayer()
        //
        //        maskLayer.path = path.cgPath
        //        self.view.layer.mask = maskLayer
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchMeHere)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.sendStringData(string: "\(Self.self)".components(separatedBy: ".").last ?? "")
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    
    @objc func touchMeHere() {
        //        self.delegate?.sendStringData(string: #function)
        
        let mas = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "TwoViewController") as! TwoViewController
        mas.delegate = self.delegate
        self.navigationController?.pushViewController(mas, animated: true)
    }
    
    
    @IBAction func actionClose(_ sender: Any) {

    }
}
