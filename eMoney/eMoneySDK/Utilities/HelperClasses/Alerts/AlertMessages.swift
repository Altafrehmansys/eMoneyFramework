//
//  AlertMessages.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 25/04/2023.
//

import Foundation
import SwiftMessages


class Alert {
    
    static func showError(title: String, message: String){
        let error = MessageView.viewFromNib(layout: .cardView)
        error.configureTheme(.error)
        error.configureContent(title: title, body: message)
        error.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .normal)
        config.overrideUserInterfaceStyle = .light
        SwiftMessages.show(view: error)
    }
    
    static func showBottomSheetError(index: Int = 0, title: String, message: String, actionBtnTitle:String? = nil, secondryBtnTitle:String? = nil, imageIconError:String? = nil, delegate:GeneralBottomSheetErrorViewDelegate? = nil){
        var title = title
        var msg = message
        if title.isEmpty {
            title = msg
            msg = ""
        }
        
        let error:GeneralBottomSheetErrorView = try! SwiftMessages.viewFromNib(named: "GeneralBottomSheetErrorView", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!)
//        let error:GeneralBottomSheetErrorView = try! SwiftMessages.viewFromNib()
        error.cornerRadius = 20
        error.configureDropShadow()
        if delegate != nil {
            error.delegate = delegate
        }
        error.setupUI()
        error.configureView(index: index, title: title, message: msg, actionBtnTitle: actionBtnTitle ?? "ok".localized, secondryButtonTitle: secondryBtnTitle, imageName: imageIconError)
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        config.overrideUserInterfaceStyle = .light
        SwiftMessages.show(config: config, view: error)
    }
    
    static func showToast(with message: String){
        let toast = MessageView.viewFromNib(layout: .statusLine)
        toast.configureTheme(.warning)
        toast.configureContent(body: message)
        toast.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .normal)
        config.overrideUserInterfaceStyle = .light
        SwiftMessages.show(view: toast)
    }
    
//    init(fromInfo title: String, message: String) {
//        self.title   = title
//        self.message = message
//        let info = MessageView.viewFromNib(layout: .messageView)
//        info.configureTheme(.info)
//        info.button?.isHidden = true
//        info.configureContent(title: title, body: message)
//        var infoConfig = SwiftMessages.defaultConfig
//        infoConfig.presentationStyle = .bottom
//        infoConfig.duration = .seconds(seconds: 8)
//        SwiftMessages.show(config: infoConfig, view: info)
//        
//    }
//    
//    init(fromError title: String, message: String) {
//        self.title   = title
//        self.message = message
//        let error = MessageView.viewFromNib(layout: .cardView)
//        error.configureTheme(.error)
//        error.configureContent(title: title, body: message)
//        error.button?.setTitle("Stop", for: .normal)
//        var config = SwiftMessages.defaultConfig
//        config.presentationStyle = .top
//        config.presentationContext = .window(windowLevel: .normal)
//        SwiftMessages.show(view: error)
//        
//    }
//    
//    init(fromSuccess title: String, message: String) {
//        self.title   = title
//        self.message = message
//        let success = MessageView.viewFromNib(layout: .cardView)
//        success.configureTheme(.success)
//        success.configureDropShadow()
//        success.configureContent(title: title, body: message)
//        success.button?.isHidden = true
//        var successConfig = SwiftMessages.defaultConfig
//        successConfig.presentationStyle = .center
//        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
//        SwiftMessages.show(config: successConfig, view: success)
//    }
//    
//    init(fromStatus title: String, message: String) {
//        self.title   = title
//        self.message = message
//        let status = MessageView.viewFromNib(layout: .statusLine)
//        status.backgroundView.backgroundColor = UIColor.purple
//        status.bodyLabel?.textColor = UIColor.white
//        status.configureContent(body: message)
//        var statusConfig = SwiftMessages.defaultConfig
//        statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
//        SwiftMessages.show(config: statusConfig, view: status)
//        
//    }
    
    class func showBannerView(image: String? = nil, title: String, delegate: ToastMessageViewDelegate? = nil) {
        
        let view:ToastMessageView = try! SwiftMessages.viewFromNib()
        if delegate != nil {
            view.delegate = delegate
        }
        view.setupUI()
        view.configureView(image: image, title: title)
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .alert)
        config.duration = .seconds(seconds: 4)
        config.overrideUserInterfaceStyle = .light
        SwiftMessages.show(config: config, view: view)
    }
}







