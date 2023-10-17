//
//  BaseToolTip.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 07/04/2023.
//

import UIKit

class BaseToolTip: UIView {
    var view:UIView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imageViewInfo: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    @IBOutlet weak var buttonRight: BaseButton!
    @IBOutlet weak var buttonLeft: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //commonInit()
        
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()

    }
    
    
    class func instantiateFromNib() -> BaseToolTip? {
            
            return UINib(nibName: "BaseToolTip", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")).instantiate(withOwner: nil, options: nil).first as? BaseToolTip
        }
    
    private func commonInit() {
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("BaseToolTip", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //view.backgroundColor = .orange
        self.addSubview(view)
        
    }

    @IBAction func buttonRightTapped(_ sender: Any) {
    }
    @IBAction func buttonLeftTapped(_ sender: Any) {
    }
}

//extension UIView {
//    /** Loads instance from nib with the same name. */
//    func loadNib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nibName = type(of: self).description().components(separatedBy: ".").last!
//        let nib = UINib(nibName: nibName, bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as! UIView
//    }
//}
//extension UINib {
//    func instantiate() -> Any? {
//        return self.instantiate(withOwner: nil, options: nil).first
//    }
//}
//
//extension UIView {
//
//    static var nib: UINib {
//        return UINib(nibName: String(describing: self), bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
//    }
//
//    static func instantiate(autolayout: Bool = true) -> Self {
//        // generic helper function
//        func instantiateUsingNib<T: UIView>(autolayout: Bool) -> T {
//            let view = self.nib.instantiate() as! T
//            view.translatesAutoresizingMaskIntoConstraints = !autolayout
//            return view
//        }
//        return instantiateUsingNib(autolayout: autolayout)
//    }
//}
