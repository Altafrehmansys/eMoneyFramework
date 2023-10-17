//
//  KYCBottomSheet.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 26/07/2023.
//

import Foundation
import UIKit
class KYCBottomSheet {
    static let shared = KYCBottomSheet()
    private  var cellActions: StandardCellActions? = nil
    
    var updateFlow:KYCState = .unRegister
    
    enum KYCState {
        case suspended
        case unRegister
        var type:String {
            switch self {
            case .unRegister:
                return  "REG_EID"
            case .suspended:
                return "REG_UAEPASS"
            }
        }
        var heading:String{
            switch self {
            case .suspended:
                return Strings.KYCBottomSheet.upgradeIsRequired
            case .unRegister:
                return Strings.KYCBottomSheet.identity_verification_required
            }
        }
        var subHeading:String{
            switch self {
            case .suspended:
                return Strings.KYCBottomSheet.uploadEmiratesIDForLimitless
            case .unRegister:
                return Strings.KYCBottomSheet.scanYourEID
            }
        }
        var lefImage:String{
            switch self {
            case .suspended:
                return  "emrites_id"
            case .unRegister:
                return "emrites_id"
            }
        }
        var title:String{
            switch self {
            case .suspended:
                return Strings.KYCBottomSheet.emirates_smart_card_ID
            case .unRegister:
                return Strings.KYCBottomSheet.emirates_smart_card_ID
            }
        }
        var subTitle:String{
            switch self {
            case .suspended:
                return Strings.KYCBottomSheet.take_pictures_both_sides
            case .unRegister:
                return Strings.KYCBottomSheet.take_pictures_both_sides
            }
        }
    }
    
    private func spaceCell(with space: CGFloat) -> SpaceTableViewCellModel {
        let cellModel = SpaceTableViewCellModel(height: space)
        return cellModel
    }
    
    
    func present() {
        
        let upgradeScreen = UpgradeScreen(rawValue: GlobalData.shared.loginData?.upgradeScreen ?? "none") ?? .none
        
        switch upgradeScreen {
        case .none:
            return
        case .consentScreen:
            let vc = FastTrackUpgradePopupViewController.instantiate(fromAppStoryboard: .Liveness)
            vc.modalPresentationStyle = .overCurrentContext
            
            if let topVC = UIApplication.getTopViewController() {
                if let tabbar = topVC.tabBarController {
                    tabbar.present(vc, animated: true)
                } else {
                    topVC.present(vc, animated: true)
                }
            }
            
        case .emiratesScreen,.selfieScreen:
            self.updateFlow = GlobalData.shared.loginData?.isEIDSuspended == false ? .unRegister:.suspended
            self.setupCellActions()
            var dataSource:[StandardCellModel] = []
            dataSource.append(GenericSingleLabelCellModel(content:updateFlow.heading,
                                                          font: AppFont.appRegular(size: .body2),
                                                          color: AppColor.eAnd_Black_80,
                                                          alignment:.center))
            dataSource.append(GenericSingleLabelCellModel(content:updateFlow.subHeading,
                                                          font: AppFont.appRegular(size: .body2),
                                                          color: AppColor.eAnd_Black_80,
                                                          alignment:.center))
            dataSource.append(spaceCell(with: 20))
            dataSource.append(RegisterOptionCellModel(actions:self.cellActions,title:updateFlow.title,
                                                      subtitle:updateFlow.subTitle,
                                                      image:updateFlow.lefImage,
                                                      type:updateFlow.type))
            
            let input = GenericBottomSheetRouter.RouterInput(dataSource: dataSource)
            let vc = GenericBottomSheetRouter.setupModule(input: input)
            let navigation = BaseNavigationController(rootViewController: vc)
            navigation.modalPresentationStyle = .overCurrentContext
            
            if let topVC = UIApplication.getTopViewController() {
                if let tabbar = topVC.tabBarController {
                    tabbar.present(navigation, animated: true)
                } else {
                    topVC.present(navigation, animated: true)
                }
            }
        }
    }
    
    private func setupCellActions() {
        cellActions = StandardCellActions{ index, model in
            if let nav = UIApplication.getTopViewController()?.navigationController as? BaseNavigationController {
                let vc = CaptureIdentityInfoRouter.setupModule()
                vc.updateType = self.updateFlow == .unRegister ? .updateEidAndSelfi:.updateEid
                nav.pushViewController(vc, animated: true)
            }
            
//            UIApplication.getTopViewController()?.dismiss(animated: true, completion: {
//                //Initiate the Registration Process here
//                print("Row Tapped...")
//            })
        }
    }
}
