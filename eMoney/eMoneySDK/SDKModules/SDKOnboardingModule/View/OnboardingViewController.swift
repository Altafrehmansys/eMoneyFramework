//
//  ParentViewController.swift
//  PodsTester
//
//  Created by Saud Waqar on 08/09/2023.
//

import UIKit
import Alamofire

enum SegueNames {
    static let first   = "mySegue"
    static let second  = "second"
    static let topView = "topView"
}

public class OnboardingViewController: UIViewController {
    
    var maximumContainerHeight: CGFloat = UIScreen.main.bounds.height
    var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    
    var navController: UINavigationController?
    var topController: TopViewController?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var constraintPanner: NSLayoutConstraint!
    
    public var onSuccess: ((String) -> ())?
    public var onFailure: ((String, String) -> ())?
    public var receivedTheme: EWalletTheme?
    public var clientID: String?
    public var partnerName: String?
    public var msisdn: String?
    
    private var shouldShowSDK = false {
        didSet {
            assert(shouldShowSDK, "Make sure you've provided ClientId, PartnerName and msisdn during initilization")
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTopBar()
    }
    
    public override func viewDidAppear( _ animdated: Bool) {
        super.viewDidAppear(animdated)
        self.getToken()
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupConstraints()
    }
    
    public override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("\(#function) \(identifier)")
        switch identifier {
        case SegueNames.first:
            guard let clientID    = self.clientID,
                  let partnerName = self.partnerName,
                  let msisdn      = self.msisdn else {
                print("clientID, partnerName, msisdn is missing")
                shouldShowSDK = false
                return false
            }
            shouldShowSDK = !clientID.isEmpty && !partnerName.isEmpty && !msisdn.isEmpty
            SDKColors.shared.onSuccess   = self.onSuccess
            SDKColors.shared.onFailure   = self.onFailure
            SDKColors.shared.clientID    = clientID
            SDKColors.shared.partnerName = partnerName
            SDKColors.shared.msisdn      = msisdn
            return true
        case SegueNames.second:
            guard let clientID    = self.clientID,
                  let partnerName = self.partnerName,
                  let msisdn      = self.msisdn else {
                print("clientID, partnerName, msisdn is missing")
                shouldShowSDK = false
                return false
            }
            shouldShowSDK = !clientID.isEmpty && !partnerName.isEmpty && !msisdn.isEmpty
            print("second \(#function)")
            return true
        case SegueNames.topView:
            return true
        default:
            return false
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(#function) \(segue.identifier)")
        switch segue.identifier {
        case SegueNames.first:
            guard let destination = segue.destination as? UINavigationController,
                  let vc = destination.topViewController as? RegisterMobileNumberViewController else {
                return
            }
            vc.delegate                  = self
            SDKColors.shared.onSuccess   = self.onSuccess
            SDKColors.shared.onFailure   = self.onFailure
            SDKColors.shared.clientID    = clientID
            SDKColors.shared.partnerName = partnerName
            SDKColors.shared.msisdn      = msisdn
            self.navController           = destination
            SDKColors.shared.setReceivedColor(theme: self.receivedTheme ?? nil)
        case SegueNames.second:
            print("second vc line executed")
        case SegueNames.topView:
            guard let destination = segue.destination as? TopViewController else {return}
            topController            = destination
            destination.delegate     = self
            destination.floDelegate  = self
        default:
            print("default executed \(#function)")
        }
    }
    
    private func setupTopBar() {
        let path = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSizeMake(20, 20))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
    
    @objc func doneCalled() {
        self.dismiss(animated: true) {
            self.mainView.removeFromSuperview()
        }
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        
        self.mainView.addGestureRecognizer(panGesture)
    }
    
    private func getSize(_ size: ScreenSizes) -> CGFloat{
        switch size {
        case .fullScreen:
            return 50
            //            return 0
        case .halfScreen:
            return UIScreen.main.bounds.height * 0.4
        }
    }
    
    private func setupConstraints() {
        self.maximumContainerHeight = UIScreen.main.bounds.height - self.view.safeAreaInsets.top
        self.constraintPanner.constant = self.getSize(.halfScreen)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let newHeight = currentContainerHeight + translation.y
        
        switch gesture.state {
        case .changed:
            if self.mainView.bounds.height < maximumContainerHeight, newHeight < maximumContainerHeight {
                self.constraintPanner.constant = newHeight
                view.layoutIfNeeded()
            }
            
        case .ended:
            switch self.mainView.bounds.height {
            case (UIScreen.main.bounds.height * 0.7..<UIScreen.main.bounds.height):
                animateContainerHeight(getSize(.fullScreen))
            case (UIScreen.main.bounds.height * 0.3..<UIScreen.main.bounds.height * 0.7):
                animateContainerHeight(getSize(.halfScreen))
            default:
                animateContainerHeight(getSize(.halfScreen))
            }
        default:
            break
        }
    }
    
    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.constraintPanner?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    deinit {
        print("\(#function) was called here")
    }
    
    func getToken() {
//        Task {
//            do {
//                let response:TokenResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.getToken(token: "Basic%20bW9iaWxlLWZlOnBhc3N3b3JkMTIz"))
//                await MainActor.run {
//                    SDKColors.shared.accessToken = response?.data?.accessToken
//                }
//
//            } catch let error as AppError {
//                await MainActor.run {
//                    print(error)
//                    Loader.shared.hideFullScreen()
//                }
//            }
//        }
        var request = URLRequest(url: URL(string: "https://enmoneyapim.azure-api.net/gettoken/v1/token?authorization=Basic%20bW9iaWxlLWZlOnBhc3N3b3JkMTIz")!)
        request.method = HTTPMethod.post
        request.headers.add(HTTPHeader(name: "custom_header", value: "pre_prod"))
        if let clientId = SDKColors.shared.clientID {
            request.headers.add(HTTPHeader(name: "client_id",   value: clientId))
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let data = data {
                self?.parseData(data)
            }
        }.resume()
    }
    
    func parseData(_ data : Data) {
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
            if let data = readableJSON["data"], let accessToken = data["accessToken"] as? String {
                SDKColors.shared.accessToken = accessToken//readableJSON["data"]?["accessToken"] as? String
            }
            
            print(SDKColors.shared.accessToken ?? "")
        }
        catch {
            print(error)
            Loader.shared.hideFullScreen()
        }
    }
}

extension OnboardingViewController: SendDataSDK {
    func sendStringData(string: String) {
        guard let topController = topController else {return}
        DispatchQueue.main.async {
            switch string {
            case "Register":
                topController.setupTopView(isFirst: true, string)
            default:
                topController.setupTopView(isFirst: false, string)
            }
        }
    }
    
    func changeScreenSize(size: ScreenSizes) {
        animateContainerHeight(getSize(size))
    }
}

extension OnboardingViewController: TopViewActionsSDK {
    func actionBack() {
        self.navController?.popViewController(animated: true)
    }
    
    func actionCross() {
        self.doneCalled()
    }
    
    func actionSwipeUp() {
        self.animateContainerHeight(getSize(.fullScreen))
    }
    
    func actionSwipeDown() {
        self.animateContainerHeight(getSize(.halfScreen))
    }
}

enum ScreenSizes {
    case fullScreen
    case halfScreen
}

protocol SendDataSDK {
    func sendStringData(string: String)
    func changeScreenSize(size: ScreenSizes)
}

protocol TopViewActionsSDK {
    func actionBack()
    func actionCross()
    func actionSwipeUp()
    func actionSwipeDown()
}

class SDKBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topRight, .topLeft],
                                cornerRadii: CGSizeMake(20, 20))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}

extension Bundle {
    static var main: Bundle {
        return Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK") ?? Bundle.main
    }
}

extension UIImage {
    convenience init?(named name: String) {
        self.init(named: name, in: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!, compatibleWith: nil)
    }
}

extension UIColor {
    convenience init?(named name: String) {
        self.init(named: name, in: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!, compatibleWith: nil)
    }
}

extension UIFont {
    
    private static var fontsRegistered: Bool = false
    
    static func registerFontsIfNeeded() {
        guard !fontsRegistered, let fontURLs = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil) else { return }
        fontURLs.forEach({ CTFontManagerRegisterFontsForURL($0 as CFURL, .process, nil) })
        fontsRegistered = true
    }
}
