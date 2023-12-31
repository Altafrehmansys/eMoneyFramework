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
        // Register to receive notification in your class
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeScreenSize(_:)), name: .onChangeScreenSize, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeTopViewColor(_:)), name: .onChangeTopViewColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeCloseButton(_:)), name: .onChangeTopCloseButton, object: nil)
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self, name: .onChangeScreenSize, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .onChangeTopViewColor, object: nil)
//        NotificationCenter.default.removeObserver(self, name: .onChangeTopCloseButton, object: nil)
    }
    public override func viewDidAppear( _ animdated: Bool) {
        super.viewDidAppear(animdated)
//        self.getToken()
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
            if let destination = segue.destination as? UINavigationController,
               let vc = destination.topViewController as? RegisterMobileNumberViewController {
                self.navController           = destination
                vc.delegate                  = self
            }
            if let destination = segue.destination as? UINavigationController,
                  let vc = destination.topViewController as? PinSDKCustomViewController {
                vc.delegate                  = self
                self.navController           = destination
            }
            if let destination = segue.destination as? UINavigationController,
                    let vc = destination.topViewController as? OtpForgotPinPopupViewController {
                vc.delegate                  = self
                vc.setupModule()
                self.navController           = destination
            }
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
    
    // handle notification
    @objc func changeScreenSize(_ notification: NSNotification) {
        if let size = notification.userInfo?["size"] as? String {
            if size == ScreenSizes.halfScreen.rawValue {
                self.changeScreenSize(size: .halfScreen, viewHeight: 0)
            }else if size == ScreenSizes.fullScreenOverContext.rawValue {
                self.changeScreenSize(size: .fullScreenOverContext, viewHeight: 0)
            } else if size == ScreenSizes.fixed.rawValue {
                guard let height = notification.userInfo?["height"] as? CGFloat else {
                    self.changeScreenSize(size: .halfScreen, viewHeight: 0)
                    return
                }
                self.changeScreenSize(size: .fixed, viewHeight:height)
            }else {
                self.changeScreenSize(size: .fullScreen, viewHeight: 0)
            }
        }
    }
    
    @objc func changeTopViewColor(_ notification: NSNotification) {
        if let isBlack = notification.userInfo?["isBlack"] as? Bool {
            topController?.setTopViewBlack(isBlack)
        }
    }
    
    @objc func changeCloseButton(_ notification: NSNotification) {
        if let isShow = notification.userInfo?["isShow"] as? Bool {
            topController?.showCloseButton(isShow)
        }
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
    
    private func getSize(_ size: ScreenSizes, height: CGFloat = 0) -> CGFloat{
        switch size {
        case .fullScreenOverContext:
            return 0
        case .fullScreen:
            return 50
        case .halfScreen:
            return UIScreen.main.bounds.height * 0.4
        case .fixed:
            return height
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
    
    func getToken() {
        Loader.shared.showFullScreen()
        Task {
            do {
                let response:TokenResponseModel? = try await ApiManager.shared.execute(OnboardingApiRouter.getToken(token: "bW9iaWxlLWZlOnBhc3N3b3JkMTIz"))
                await MainActor.run {
                    Loader.shared.hideFullScreen()
                    SDKColors.shared.accessToken = response?.data?.accessToken
                }

            } catch let error as AppError {
                await MainActor.run {
                    print(error)
                    Loader.shared.hideFullScreen()
                }
            }
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
            case "enter_pin".localized:
                topController.setupTopViewForEnterPin(string)
            default:
                topController.setupTopView(isFirst: false, string)
            }
        }
    }
    
    func changeScreenSize(size: ScreenSizes, viewHeight: CGFloat) {
        if size == ScreenSizes.fixed {
            let height = self.view.frame.size.height
            let topAnchor = height - viewHeight - (topController?.view.frame.size.height ?? 44)
            animateContainerHeight(getSize(size, height: topAnchor))
        } else {
            animateContainerHeight(getSize(size))
        }
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

enum ScreenSizes: String {
    case fullScreen
    case halfScreen
    case fullScreenOverContext
    case fixed
}

protocol SendDataSDK {
    func sendStringData(string: String)
//    func changeScreenSize(size: ScreenSizes)
    func changeScreenSize(size: ScreenSizes, viewHeight: CGFloat)
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
        
        overrideUserInterfaceStyle = .light
        
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
