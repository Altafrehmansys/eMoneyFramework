//
//  TwoViewController.swift
//  PodsTester
//
//  Created by Saud Waqar on 08/09/2023.
//

import UIKit

class TwoViewController: SDKBaseViewController {
    
    var delegate: SendDataSDK?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let mas = UIStoryboard(name: "Other", bundle: Bundle.main).instantiateViewController(withIdentifier: "ThreeViewController") as! ThreeViewController
        mas.delegate = self.delegate
        self.navigationController?.pushViewController(mas, animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.delegate?.sendStringData(string: "\(Self.self)".components(separatedBy: ".").last ?? "")
        
    }
    
    @IBAction func actionClose(_ sender: Any) {

    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
