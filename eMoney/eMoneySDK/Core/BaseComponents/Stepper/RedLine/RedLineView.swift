//
//  RedLineView.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 04/04/2023.
//

import Foundation
import UIKit


class RedLineView : UIView {
    var view:UIView!
    @IBOutlet weak var viewContent: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    private func commonInit() {
        view = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!.loadNibNamed("RedLineView", owner: self, options: nil)![0] as? UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
}
