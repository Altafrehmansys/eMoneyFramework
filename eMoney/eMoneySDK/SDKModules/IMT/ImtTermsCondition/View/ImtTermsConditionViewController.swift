//
//  ImtTermsConditionViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 02/06/2023.
//  
//

import Foundation
import UIKit
import WebKit

class ImtTermsConditionViewController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    

    // MARK: Properties

    var presenter: ImtTermsConditionPresenterProtocol?

    // MARK: Lifecycle

    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        loadurl()
       
    }
    func loadurl(){
        let request = URLRequest(url: URL(string:"https://www.eandmoney.com/en/aboutus/prepaidcard_terms-and-conditions.html")!)
        webView?.load(request)
        self.labelTitle.text = "learn".localized
    }
    
   
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        
    }
    
}


extension ImtTermsConditionViewController: ImtTermsConditionViewProtocol {
    
}
