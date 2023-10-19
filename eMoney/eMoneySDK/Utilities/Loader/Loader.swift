//
//  Loader.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/03/2023.
//

import Foundation
//import NVActivityIndicatorView
import UIKit

class Loader {
    
    static let shared = Loader()
    
    private let restorationIdentifier = "NVActivityIndicatorViewContainer"
    
    private init() {}
    
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [AppColor.eAnd_Red], lineWidth: 9)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
//    var nvActivityIndicator: NVActivityIndicatorView?
//    var bgView: UIView?
    
    func show(view: UIView) {
        configureLoader(view)
    }
    func hide(view: UIView) {
        removeLoder(view)
    }
    
    func showFullScreen() {
        configureLoader()
    }
    func hideFullScreen() {
        removeLoder()
    }
    
    func showFullScreenLoaderWithLabel(text:String){
        configureLoaderWithLabel(text: text)
    }
    func hideFullScreenLoaderWithLabel(){
        removeLoder()
    }
    private func removeLoder(_ view: UIView? = nil) {
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }

        for subview in view?.subviews ?? keyWindow.subviews{
            if subview.restorationIdentifier == self.restorationIdentifier {
                subview.removeFromSuperview()
            }
        }
    }
   
    private func configureLoader(_ view: UIView? = nil) {

        //Checking if loader already exits
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        var flag = false
        for subview in view?.subviews ?? keyWindow.subviews {
            if subview.restorationIdentifier == self.restorationIdentifier {
                subview.removeFromSuperview()
                flag = true
                break
            }
        }
        
        if !flag {
            
            let bgView = UIView(frame: view?.frame ?? keyWindow.frame)
            bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.20)
            bgView.restorationIdentifier = self.restorationIdentifier
            let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            let nvActivity = UIActivityIndicatorView.init(frame: frame)
            nvActivity.color = AppColor.eAnd_Red
//            nvActivity.startAnimating()
            
//            let nvActivity = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: AppColor.eAnd_Red, padding: 10)
            nvActivity.startAnimating()
            nvActivity.center = view?.center ?? keyWindow.center
            bgView.addSubview(nvActivity)
            
            if let view = view {
                view.addSubview(bgView)
            }else{
                keyWindow.addSubview(bgView)
            }
            
        }
        
    }

    private func configureLoaderWithLabel(_ view: UIView? = nil,text:String) {

        //Checking if loader already exits
        guard let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        var flag = false
        for subview in view?.subviews ?? keyWindow.subviews {
            if subview.restorationIdentifier == self.restorationIdentifier {
                subview.removeFromSuperview()
                flag = true
                break
            }
        }
        
        if !flag {
            let bgView = UIView(frame: view?.frame ?? keyWindow.frame)
            bgView.backgroundColor = .white
            bgView.restorationIdentifier = self.restorationIdentifier
            bgView.addSubview(loadingIndicator)

            NSLayoutConstraint.activate([
                loadingIndicator.centerXAnchor
                    .constraint(equalTo:bgView.centerXAnchor),
                loadingIndicator.centerYAnchor
                    .constraint(equalTo:bgView.centerYAnchor),
                loadingIndicator.widthAnchor
                    .constraint(equalToConstant: 58),
                loadingIndicator.heightAnchor
                    .constraint(equalTo: self.loadingIndicator.widthAnchor)
            ])
            loadingIndicator.isAnimating = true

            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            label.textColor = AppColor.eAnd_Black_80
            label.font = AppFont.appSemiBold(size: .body1)
            bgView.addSubview(label)
            
            label.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 20).isActive = true
            label.leadingAnchor.constraint(equalTo: bgView.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: bgView.trailingAnchor).isActive = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            if let view = view {
                view.addSubview(bgView)
            }else{
                keyWindow.addSubview(bgView)
            }
        }
        
    }
}

/// Change by Uzair
extension Loader {
    func showWithoutGreyBackground(in view: UIView) {
        var flag = false
        for subview in view.subviews {
            if subview.restorationIdentifier == self.restorationIdentifier {
                subview.removeFromSuperview()
                flag = true
                break
            }
        }
        
        if !flag {
            let bgView = UIView()
            bgView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            bgView.backgroundColor = .clear
            bgView.restorationIdentifier = self.restorationIdentifier
            let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//            let nvActivity = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: AppColor.eAnd_Red, padding: 20)
            let nvActivity = UIActivityIndicatorView.init(frame: frame)
            nvActivity.color = AppColor.eAnd_Red
            nvActivity.startAnimating()
            nvActivity.center = bgView.center
            bgView.addSubview(nvActivity)
            view.addSubview(bgView)
        }
    }
}
