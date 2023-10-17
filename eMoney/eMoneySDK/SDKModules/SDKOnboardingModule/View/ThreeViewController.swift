//
//  ThreeViewController.swift
//  PodsTester
//
//  Created by Saud Waqar on 08/09/2023.
//

import UIKit

class ThreeViewController: SDKBaseViewController {
    var delegate: SendDataSDK?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.sendStringData(string: "\(Self.self)".components(separatedBy: ".").last ?? "")        
    }

    
    @IBAction func actionCloseForMe(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildMe() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
