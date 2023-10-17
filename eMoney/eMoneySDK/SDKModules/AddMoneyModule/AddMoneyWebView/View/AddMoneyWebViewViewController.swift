//
//  AddMoneyWebViewViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 01/05/2023.
//  
//

import Foundation
import WebKit

class AddMoneyWebViewViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var redirectingView: UIView!
    @IBOutlet weak var progressParentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // MARK: Properties
    var presenter: AddMoneyWebViewPresenterProtocol!
    let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 55, height: 55), lineWidth: 9, rounded: true)
    let keyPath = "estimatedProgress"
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    // Observe value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == self.keyPath {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
}

extension AddMoneyWebViewViewController: AddMoneyWebViewViewProtocol {
    func setupUI() {
        self.setupNavigation()
        self.setupRedirectingView()
        self.initiateRequest()
        
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: keyPath, options: .new, context: nil)
    }
    
    private func initiateRequest() {
        if let request = presenter.request {
            webView.load(request)
        }
    }
    
    private func addProgressView() {
        progressView.trackColor = AppColor.eAnd_Grey_10
        progressView.progressColor = AppColor.eAnd_Red_100
        progressParentView.addSubview(progressView)
    }
    
    private func setupNavigation() {
        self.createNavBackBtn()
        
        if presenter.flowType == .initializeDebitCard {
            self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: Strings.AddMoney.addNewCard)
        }
    }
    
    private func setupRedirectingView() {
        
        let title = presenter.flowType == .bankAcount ? Strings.AddMoney.redirectingToUAEPaymentGateway : Strings.AddMoney.redirectingToCardCateway
        
        titleLabel.text = title
        titleLabel.font = AppFont.appSemiBold(size: .h6)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        subtitleLabel.text = Strings.AddMoney.pleaseDoNotRefresh
        subtitleLabel.font = AppFont.appRegular(size: .body3)
        subtitleLabel.textColor = AppColor.eAnd_Grey_100
    }
    
    private func showRedirectingView() {
        addProgressView()
        
        UIView.animate(withDuration: 0.1) {
            self.redirectingView.alpha = 1
            self.redirectingView.isHidden = false
            self.webView.alpha = 0
            self.webView.isHidden = true
        }
    }
    
    private func hideRedirectingView() {
        UIView.animate(withDuration: 0.1) {
            self.redirectingView.alpha = 0
            self.redirectingView.isHidden = true
            self.webView.alpha = 1
            self.webView.isHidden = false
        } completion: { [weak self] (status) in
            if status {
                self?.progressView.removeFromSuperview()
                self?.progressView.progress = 0
            }
        }
    }
    
    func reloadWebView(isHidden: Bool) {
        self.initiateRequest()
    }
    
    func stopLoading() {
        self.webView.stopLoading()
    }
}


// MARK: - WKNavigationDelegate
extension AddMoneyWebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showRedirectingView()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideRedirectingView()
        
        if presenter.flowType == .debitCard {
            webView.evaluateJavaScript("document.documentElement.outerHTML") { (html, error) in
                guard let html = html as? String else {
                    debugPrint(error)
                    return
                }
                print("html is")
                print(html)
                
                if html.contains("You have successfully added money to your account.") {
                    if let data = html.components(separatedBy: "pre-wrap;\">").last?.replacingOccurrences(of: "</pre></body></html>", with: "").data(using: .utf8) ,
                       let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                       let data = json["data"] as? [String:Any],
                       let _ = data["title"] as? String,
                       let msg = data["message"] as? String {
                        
                        debugPrint(json)
                        debugPrint("message" + msg)
                        
                    }
                }
                // Here you have HTML of the whole page.
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideRedirectingView()
        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.localizedDescription)
    }
    
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        self.hideRedirectingView()
//        Alert.showBottomSheetError(title: Strings.Generic.somethingWentWrong, message: error.localizedDescription)
//    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let trust = challenge.protectionSpace.serverTrust {
                let exceptions = SecTrustCopyExceptions(trust)
                SecTrustSetExceptions(trust, exceptions)
                completionHandler(.useCredential, URLCredential(trust: trust))
            }
        }
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if presenter.flowType == .debitCard {
            if let urlStr = navigationAction.request.url?.absoluteString {
                debugPrint("Loading URL: \(urlStr)")
                if urlStr.contains("debit-cards/finalize-add-card"){
                    
                }
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            let headers = response.allHeaderFields as Dictionary
            self.presenter.extractData(from: headers)
        }
        decisionHandler(.allow)
    }
}

extension AddMoneyWebViewViewController: GeneralBottomSheetErrorViewDelegate {
    func tryAgainBtnTapped(index: Int) {
        presenter.goBack()
    }
}
