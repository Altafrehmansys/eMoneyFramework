//
//  BaseViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 09/03/2023.
//

import UIKit
//import IQKeyboardManagerSwift

typealias KeyboardShowHideCallBack = (_ isHidden: Bool, _ frame : CGRect) -> Void

public class BaseViewController: UIViewController, InternetConnectionErrorViewControllerDelegate {
    
    var keyboardCallBack: KeyboardShowHideCallBack?
    private var viewTranslation = CGPoint(x: 0, y: 0)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.hideBackButton()
        overrideUserInterfaceStyle = .light
        self.navigationController?.view.overrideUserInterfaceStyle = .light
    }
    
    private func changeTextColorsFromSDK() {
//        guard let color = SDKColors.shared.receivedTheme?.color else {
//            returnd
//        }
//        self.view.backgroundColor =
        
//        self.view.subviews.forEach {
//            switch $0 {
//            case is UILabel:
//                guard let color = SDKColors.shared.receivedTheme?.color else {
//                    return
//                }
//                ($0 as! UILabel).textColor = color//.red
//            case is UIButton:
//                guard let color = SDKColors.shared.receivedTheme?.buttonTextColor else {
//                    return
//                }
//                ($0 as! UIButton).titleLabel!.textColor = color
//            default:
//                print("")
//            }
//        }
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotifications()
        removeBackButton()
    }
    
    func isHideNavigation(_ status: Bool){
        //self.navigationController?.navigationBar.isHidden = status
        self.navigationController?.setNavigationBarHidden(status, animated: true)
    }
    
    private func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setScreenSize(size: ScreenSizes, fixedHeight: CGFloat = 0) {
        switch size {
        case .fullScreen:
            NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":ScreenSizes.fullScreen.rawValue])
        case .halfScreen:
            NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":ScreenSizes.halfScreen.rawValue])
        case .fullScreenOverContext:
            NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":ScreenSizes.fullScreenOverContext.rawValue])
        case .fixed:
            NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":ScreenSizes.fixed.rawValue, "height": fixedHeight])
        }
    }
    
    func setTitleImage(){
        let image: UIImage = UIImage(named: "title_logo")!
        let imageView = UIImageView()//UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
    //    func createCrossButton(){
    //        let btn = UIButton()
    //
    //        btn.setImage(UIImage(named: "cross"), for: .normal)
    //        btn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        self.view.addSubview(btn)
    //        btn.widthAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(30)).isActive = true
    //        btn.heightAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(44)).isActive = true
    //        btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    //        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: DesignUtility.getValueFromRatio(15)).isActive = true
    //    }
    
    //    func createBackButton() {
    //        let btn = UIButton()
    //        let img = UIImage(named: "back")?.flipIfNeeded()
    //        btn.setImage(img, for: .normal)
    //        btn.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //
    //        btn.contentHorizontalAlignment = MOLHLanguage.currentAppleLanguage() == "en" ? .left:.right
    //        self.view.addSubview(btn)
    //        btn.widthAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(30)).isActive = true
    //        btn.heightAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(44)).isActive = true
    //        btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    //        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: DesignUtility.getValueFromRatio(15)).isActive = true
    //    }
    
    //    func createMenuButton() {
    //        let btn = UIButton()
    //        btn.setImage(UIImage(named: "nav"), for: .normal)
    //        btn.addTarget(self, action: #selector(menuAction), for: .touchUpInside)
    //        btn.translatesAutoresizingMaskIntoConstraints = false
    //        self.view.addSubview(btn)
    //        btn.widthAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(30)).isActive = true
    //        btn.heightAnchor.constraint(equalToConstant: DesignUtility.getValueFromRatio(44)).isActive = true
    //        btn.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    //        btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: DesignUtility.getValueFromRatio(10)).isActive = true
    //
    //    }
    
    
    
    
    //Mark : Customizing navigation bar, adding bar buttons and custom title view
    //    func setupAppDefaultNavigationBar()  {
    //
    //        //Setting navigation bar background color, its font and title color
    //        let barBgColor = UIColor.init(hexString: "#707070")
    //        let titleFont = UIFont.init(name: "FuturaStd-Medium", size: DesignUtility.getFontSize(fSize: 18))
    //
    //        //self.navigationController?.navigationBar.setCustomNavigationBarWith(navigationBarTintColor: barBgColor, navigationBarTitleFont: titleFont!, navigationBarForegroundColor: UIColor.white)
    //
    ////        self.navigationController?.view.backgroundColor = UIColor.white
    //        self.navigationItem.hidesBackButton = true
    //        //If navigation controller have more than 1 view controller then add backbutton
    //        if self.navigationController != nil{
    //
    ////            self.setupSideButton()
    //        }
    //    }
    
    func calculateCollectionViewHeight(collectionView: UICollectionView,columns:Int = 1) -> CGFloat {
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        
        let itemSize = flowLayout.itemSize
        let interitemSpacing = flowLayout.minimumInteritemSpacing
        let sectionInsets = flowLayout.sectionInset
        
        let numberOfColumns = columns // Adjust according to your layout
        
        let numberOfRows = (numberOfItems + numberOfColumns - 1) / numberOfColumns
        
        let totalItemHeight = (itemSize.height * CGFloat(numberOfRows))
        let totalSpacingHeight = (interitemSpacing * CGFloat(numberOfRows - 1))
        let totalInsetHeight = (sectionInsets.top + sectionInsets.bottom)
        
        let totalHeight = totalItemHeight + totalSpacingHeight + totalInsetHeight
        
        return totalHeight
    }
    
    
    func animateTableView(tblView: UITableView){
        
        tblView.reloadData()
        let cells = tblView.visibleCells
        let tableViewHeight = tblView.bounds.size.height
        var delayCounter = 0.0
        
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        for cell in cells{
            UIView.animate(withDuration: 1.5, delay: (delayCounter * 0.09), usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            delayCounter += 1
        }
    }
    
    func createNavBackBtn(isWhite:Bool = false){
        if (self.navigationController?.viewControllers.count) ?? 0  > 1{
            //Adding bar button items with given image and its position inside navigation bar and its selector
            let img = UIImage.init(named: isWhite ? "backArrow-white":"backArrow-black")?.flipIfNeeded()
            self.addBarButtonItemWithImage(img, .left, self, #selector(self.popViewController))
        }
    }
    
    func createNavCloseBtn(isWhite:Bool = false){
        let img = UIImage(named: "Close")?.withTintColor(AppColor.eAnd_Grey_100)
        self.addBarButtonItemWithImage(img, .right, self, #selector(self.dismissController))
    }
    
    //Pop view controller
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissController() {
        self.dismiss(animated: true)
    }
    
    //Adding bar button items with given image and its position inside navigation bar and its selector
    /// Adding Navigation bar button for given position (e.g .left , .right)
    func addBarButtonItemWithImage(_ image:UIImage?,_ postion: CustomBarButtonItemPosition, _ target:UIViewController, _ selector:Selector) {
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(image ?? UIImage(), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 39, height: 44)
        
        btn1.addTarget(self, action: selector, for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)
        
        switch postion {
        case .left:
            //                btn1.contentHorizontalAlignment = .leading
            
            if self.navigationItem.leftBarButtonItem != nil{
                
                if (self.navigationItem.leftBarButtonItems?.count)! > 0{
                    
                    self.navigationItem.leftBarButtonItems?.append(item1)
                }
            }else{
                
                self.navigationItem.leftBarButtonItem = item1
            }
            
        case .right:
            //                btn1.contentHorizontalAlignment = .trailing
            if self.navigationItem.rightBarButtonItem != nil{
                
                if (self.navigationItem.rightBarButtonItems?.count)! > 0{
                    
                    self.navigationItem.rightBarButtonItems?.append(item1)
                }
            }
            else{
                
                self.navigationItem.rightBarButtonItem = item1
            }
        }
    }
    
    func removeBackButton(){
        self.navigationItem.hidesBackButton = true
    }
    
    func showInternetErrorScreen(){
        let vc = InternetConnectionErrorViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    //MARK: - InternetConnectionErrorViewControllerDelegate
    func didInternetErrorTryAgainTapped() {
        
    }
    
    func didInternetErrorCancelTapped() {
        
    }
}

// MARK: - Keyboard Frame settings
extension BaseViewController {
    
    private func registerKeyboardNotifications() {
        debugPrint("Observers attached")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObserver() {
        debugPrint("Observers removed")
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        self.keyboardCallBack?(false, keyboardFrame)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        self.keyboardCallBack?(true, keyboardFrame)
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// Update the constraint of bottom button when keyboard appearing
    /// provide the bottom padding as well this will be used when the keyboard is hidden
    func updateBottomBtnConstraintOnKeyboardAppearing(_ constraint: NSLayoutConstraint, bottomPadding: CGFloat) {
//        self.keyboardCallBack = { (isHidden, frame) in
//            if isHidden {
                constraint.constant = bottomPadding
//            } else {
//                
//                let height = UIDevice.current.hasNotch ? (frame.size.height - 20) : frame.size.height
//                constraint.constant = height
//            }
//        }
    }
}


// MARK: - Handle Custom Swipe down.
extension BaseViewController {
    
    func addSwipeDown(on view: UIView) {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        
        guard let gestureView = sender.view else {
            debugPrint("Gesture View is not attached")
            return
        }
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            
            guard viewTranslation.y >= 0 else {
                return
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                gestureView.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    gestureView.transform = .identity
                })
            } else {
                UIView.animate(withDuration: 0.3) {
                    gestureView.transform = CGAffineTransform(translationX: 0, y: 1000)
                } completion: { [unowned self] (status) in
                    self.dismiss(animated: false, completion: nil)
                }
            }
        default:
            break
        }
    }
}
