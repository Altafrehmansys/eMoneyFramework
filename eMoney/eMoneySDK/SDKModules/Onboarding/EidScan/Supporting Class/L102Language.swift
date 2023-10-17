//
//  L102Language.swift
//  Localization102
//
//  Created by Moath_Othman on 2/24/16.
//  Copyright © 2016 Moath_Othman. All rights reserved.
//

import UIKit

/// L102Language
/* ---------------------------
class L102Language {
    
    /// get current Apple language
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
        let current = langArray.firstObject as! String
        let endIndex = current.startIndex
        let currentWithoutLocale = current[..<current.index(endIndex, offsetBy: 2)]
        return String(currentWithoutLocale)
    }
    
    class func currentAppleLanguageFull() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: "AppleLanguages") as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: "AppleLanguages")
        userdef.synchronize()
        
        //Manual text allignment changing method for controls
        
        L102Localizer.DoTheMagic()
    }
    
    class var isRTL: Bool {
        return L102Language.currentAppleLanguage() == "ar"
    }
    
    class func currentLocale() -> NSLocale{
        let localeLanguage = NSLocale.init(localeIdentifier: self.currentAppleLanguage())
        return localeLanguage
    }
    
    class func changeAppLanguage() {
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    
  
    
    
    /*
    class func changeAppLanguageAndResetHomeScreen() {
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
         // Updating the current screen UI after chnaging the application language
         DispatchQueue.main.async {
            AppData.sharedAD.drawerController.drawerDirection = (L102Language.isRTL) ? .right : .left
            let controller = UIStoryboard.instatiateHomeViewController()
            AppData.sharedAD.drawerController.mainViewController = UINavigationController(
                rootViewController: controller
            )
            AppData.sharedAD.drawerController.setDrawerState(.closed, animated: true)
         }
        
    }*/
}


---------------------------- */
