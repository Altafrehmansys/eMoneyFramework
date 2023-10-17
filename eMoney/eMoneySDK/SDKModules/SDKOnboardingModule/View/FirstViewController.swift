//
//  FirstViewController.swift
//  TesterSDKSampler
//
//  Created by Saud Waqar on 06/09/2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgToChange: UIImageView!
    
    var delegate: SendDataSDK?
    
    var myBool = false {
        didSet {
            DispatchQueue.main.async {
                self.imgToChange.image = self.data[self.myBool]
            }
        }
    }
    
    let data: [Bool: UIImage] = [
        true: UIImage(named: "arrow-right-with-background")!,
        false: UIImage(named: "bag-tick")!,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewTop.backgroundColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.sendStringData(string: "me")
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func actionTapHere(_ sender: UIButton!) {
        self.myBool.toggle()
    }
}
