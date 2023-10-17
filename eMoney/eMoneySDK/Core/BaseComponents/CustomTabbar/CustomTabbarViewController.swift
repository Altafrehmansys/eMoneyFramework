//
//  CustomTabbarViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 10/04/2023.
//

import UIKit

class CustomTabbarViewController: UITabBarController {

    let home = UITabBarItem(title: "Home", image: UIImage(named: "Tab_Home_normal"), selectedImage: UIImage(named: "Tab_Home_selected")?.withRenderingMode(.alwaysOriginal))
    let account = UITabBarItem(title: "Account", image: UIImage(named: "Tab_Accounts_normal"), selectedImage: UIImage(named: "Tab_Accounts_selected")?.withRenderingMode(.alwaysOriginal))
    let services = UITabBarItem(title: "Services", image: UIImage(named: "Tab_Services_normal"), selectedImage: UIImage(named: "Tab_Services_selected")?.withRenderingMode(.alwaysOriginal))
    let reward = UITabBarItem(title: "Rewards", image: UIImage(named: "Tab_Rewards_normal"), selectedImage: UIImage(named: "Tab_Rewards_selected")?.withRenderingMode(.alwaysOriginal))
    
    var indicatorView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.backgroundColor = .white
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppColor.eAnd_Black_80,
            NSAttributedString.Key.font: AppFont.appRegular(size: .body5)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppColor.eAnd_Red_Gradient_Start,
            NSAttributedString.Key.font: AppFont.appSemiBold(size: .body5)], for: .selected)
        
        assignViewControllers()
        addIndicatorView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    private func assignViewControllers() {
        
        let vc = HomeScreenRouter.setupModule()
        let homeNav = BaseNavigationController.instantiate(fromAppStoryboard: .Onboarding)
        homeNav.viewControllers = [vc]
        homeNav.tabBarItem = home
        
        let accountVC = WalletRouter.setupModule()
        let accountNav = BaseNavigationController.instantiate(fromAppStoryboard: .Onboarding)
        accountNav.viewControllers = [accountVC]
        accountNav.tabBarItem = account
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .cyan
        vc3.tabBarItem = services
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .systemGreen.withAlphaComponent(0.8)
        vc4.tabBarItem = reward
        
        viewControllers = [homeNav, accountNav, vc3, vc4]
    }
    
    private func addIndicatorView() {
        let index = LocaleManager.isRTLLanguage() ? ((tabBar.items?.count ?? 0) - 1) : 0
        guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
            return
        }
        indicatorView = UIImageView(frame: CGRect(x: tabView.center.x, y: 0, width: 60, height: 2))
        indicatorView.image = UIImage(named: "tab_indicator")
        tabBar.addSubview(indicatorView)
    }
    
    private func selectIndex(of item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        guard let tabView = tabBar.subviews[index+1] as? UIControl else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            self.indicatorView.center.x = tabView.center.x
        }
    }
}


// MARK: - Delegate Methods
extension CustomTabbarViewController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.selectIndex(of: item)
    }
}

// MARK: - Custom Tab bar height
class CustomTabBar: UITabBar {
    
    // MARK: - Inspectable
    @IBInspectable var height: CGFloat = 22
    
    // MARK: - Attributes
    private var shapeLayer: CALayer?
    var radii: CGFloat = 0.0
    fileprivate lazy var defaultTabBarHeight = { frame.size.height }()
    lazy var isIphoneXOrHigher: Bool = {
            return UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height >= 2436
        }()
    
    lazy var tabbarHeight: CGFloat = {
        return (isIphoneXOrHigher ? 83 : 49) + height
    }()
    
    // MARK: - Override Methods
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = tabbarHeight
        }
        return sizeThatFits
    }

    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
    }
    
    func refreshCorner(radius: CGFloat = 16) {
        radii = radius
        addShape()
    }

    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.fillColor = UIColor.white.cgColor
        //shapeLayer.lineWidth = 2
        shapeLayer.shadowColor = AppColor.eAnd_Shadow.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0 , height: -2);
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowRadius = 16
        shapeLayer.shadowPath =  createPath()
        

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft,.topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        return path.cgPath
    }
}
