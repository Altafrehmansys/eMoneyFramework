//
//  UINavigationItemExtension.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 20/03/2023.
//

import Foundation
import UIKit

extension UINavigationItem {
    func setTitle(title: String, subtitle: String? = nil, isBoldTitle:Bool = false, isBlackNav:Bool = false) {
        var titleColor = AppColor.eAnd_Grey_100
        var subTitleColor = AppColor.eAnd_Black_80
        if isBlackNav {
            if isBoldTitle {
                titleColor = AppColor.eAnd_White
                subTitleColor = AppColor.eAnd_Grey_50
            }else{
                titleColor = AppColor.eAnd_Grey_50
                subTitleColor = AppColor.eAnd_White
            }
        }else if isBoldTitle {
            titleColor = AppColor.eAnd_Black_80
            subTitleColor = AppColor.eAnd_Grey_100
        }
//        let titleColor = isBlackNav ? AppColor.eAnd_Grey_50:AppColor.eAnd_Grey_100
//        let subTitleColor = isBlackNav ? AppColor.eAnd_White:AppColor.eAnd_Black_80
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = isBoldTitle ? AppFont.appSemiBold(size: .body2):AppFont.appRegular(size: .body3)
        titleLabel.textColor = titleColor

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = isBoldTitle ? AppFont.appRegular(size: .body3):AppFont.appSemiBold(size: .body2)
        subtitleLabel.textColor = subTitleColor

        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.layoutSubviews()
        
        //let width = max(titleLabel.frame.size.width, subtitleLabel.frame.size.width)
        
        //stackView.frame = CGRectMake(0, 6, 200, 35)
        let titleView = UIView(frame: CGRectMake(0, 0, 200, 44))
        
        titleView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor, constant: 0.0).isActive = true
        if let subtileString = subtitle, subtileString != ""{
            subtitleLabel.isHidden = false
            stackView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 1.0).isActive = true
        }else{
            titleLabel.isHidden = true
            subtitleLabel.text = title
            stackView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0.0).isActive = true
        }
        
               
        self.titleView = titleView
    }
    
//    func setTitle(title:String, subtitle:String) {
//        let textColor = UIColor.black
//
//        let titleLabel = UILabel(frame: CGRectMake(0, 6, 0, 0))
//        titleLabel.textColor = textColor
//        titleLabel.font = .boldSystemFont(ofSize: 16)
//        titleLabel.text = title
//        titleLabel.sizeToFit()
//
//        let subtitleLabel = UILabel(frame: CGRectMake(0, 30, 0, 0))
//        subtitleLabel.textColor = textColor.withAlphaComponent(0.6)
//        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
//        subtitleLabel.text = subtitle
//        subtitleLabel.sizeToFit()
//        subtitleLabel.clipsToBounds = false
//
//        let titleView = UIView(frame: CGRectMake(0, 0, max(titleLabel.frame.size.width, subtitleLabel.frame.size.width), 44))
//        titleView.addSubview(titleLabel)
//        titleView.addSubview(subtitleLabel)
//
//        let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width
//
////        if widthDiff < 0 {
////            let newX = widthDiff / 2
////            subtitleLabel.frame.origin.x = abs(newX)
////        } else {
////            let newX = widthDiff / 2
////            titleLabel.frame.origin.x = newX
////        }
//
//        if (subtitleLabel.frame.size.width > titleLabel.frame.size.width) {
//            var titleFrame = titleLabel.frame
//            titleFrame.size.width = subtitleLabel.frame.size.width
//            titleLabel.frame = titleFrame
//            titleLabel.textAlignment = .center
//        }
//
//
//
//        titleView.clipsToBounds = false
//        self.titleView?.clipsToBounds = false
//        self.titleView = titleView
//    }
}
