//
//  TermsConditionsViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/05/2023.
//  
//

import Foundation
import UIKit
import WebKit

class TermsConditionsViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties

    var presenter: TermsConditionsPresenterProtocol?
    var enumPrivacyType = PrivacypolicyType.termsCondition
    var isLoadDirectUrl:Bool = false
    
    let TERMS_AND_CONDITONS_URL = "https://www.eandmoney.com/en/aboutus/terms-and-conditions.html"
    let PRIVACY_POLICY_URL = "https://www.eandmoney.com/en/aboutus/privacy-policy.html"

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       setViewInterface()
    }
    func setViewInterface(){
//        self.isHideNavigation(false)
//        self.createNavBackBtn()
        titleLabel.font = AppFont.appRegular(size: .body2)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        var directUrl = ""
        switch enumPrivacyType {
        case .termsCondition:
            self.titleLabel.text = "term_condition".localized
            directUrl = TERMS_AND_CONDITONS_URL
        case .privacyPolicy:
            self.titleLabel.text = "privacy_policy".localized
            directUrl = PRIVACY_POLICY_URL
        }
        
        if isLoadDirectUrl {
            loadWebview(url: directUrl)
        }
        else {
            presenter?.getTermsAndConditionsFromServer(type: enumPrivacyType.rawValue)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    func loadWebview(url:String){
        let request = URLRequest(url: URL(string: url)!)
        webView?.load(request)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func buttonCloseTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TermsConditionsViewController: TermsConditionsViewProtocol {
    func termsConditionResponse(response: TermsConditionsResponseModel) {
        loadWebview(url: response.data?.html ?? "https://www.eandmoney.com/en/aboutus/prepaidcard_terms-and-conditions.html")
    }
    func termsConditionResponseError(error: AppError) {
        print(error)
    }
}
