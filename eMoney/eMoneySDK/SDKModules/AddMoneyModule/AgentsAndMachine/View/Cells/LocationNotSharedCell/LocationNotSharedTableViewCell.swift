//
//  LocationNotSharedTableViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//

import UIKit

class LocationNotSharedTableViewCell: StandardCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var goToSettingsBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let model = cellModel as? LocationNotSharedTableViewCellModel {
            title.text = model.title
            title.font = model.titleLblFontAndColor.0
            title.textColor = model.titleLblFontAndColor.1
            
            subTitle.text = model.subTitle
            subTitle.font = model.subTitleFontAndColor.0
            subTitle.textColor = model.subTitleFontAndColor.1
            
            goToSettingsBtn.titleLabel?.text = model.goToSettingsBtn
            goToSettingsBtn.titleLabel?.font = model.goToSettingsBtnFontAndColor.0
            goToSettingsBtn.titleLabel?.textColor = model.goToSettingsBtnFontAndColor.1
        
        }
    }
    
    
    @IBAction func goToSettingsAction(_ sender: Any) {
        showgoToSettingsAlert()
    }
    
    func showgoToSettingsAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services to use this feature.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
            // Navigate to device settings
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        if let parentVC = self.parentViewController {
            parentVC.present(alert, animated: true, completion: nil)
        }
    }
    
    var parentViewController: UIViewController? {
           var parentResponder: UIResponder? = self
           while parentResponder != nil {
               parentResponder = parentResponder!.next
               if let viewController = parentResponder as? UIViewController {
                   return viewController
               }
           }
           return nil
    }
}


// MARK: - Cell model
final class LocationNotSharedTableViewCellModel: StandardCellModel {
    let title: String
    let titleLblFontAndColor: (UIFont, UIColor)
    
    let subTitle: String
    let subTitleFontAndColor: (UIFont, UIColor)
    
    let goToSettingsBtn: String
    let goToSettingsBtnFontAndColor: (UIFont, UIColor)
    
    
    init(actions: StandardCellModel.ActionsType = nil,
         title: String,
         titleLblFontAndColor: (UIFont, UIColor) = (AppFont.appRegular(size: .body2), AppColor.eAnd_Black_80),
         subTitle: String,
         subTitleFontAndColor: (UIFont, UIColor) = (AppFont.appRegular(size: .body3), AppColor.eAnd_Grey_100),
         goToSettingsBtn: String,
         goToSettingsBtnFontAndColor: (UIFont, UIColor) = (AppFont.appSemiBold(size: .body2), AppColor.eAnd_Red_100)
    ) {
        
        self.title = title
        self.titleLblFontAndColor = titleLblFontAndColor
        
        self.subTitle = subTitle
        self.subTitleFontAndColor = subTitleFontAndColor
        
        self.goToSettingsBtn = goToSettingsBtn
        self.goToSettingsBtnFontAndColor = goToSettingsBtnFontAndColor

        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return LocationNotSharedTableViewCell.identifier()
    }
}
