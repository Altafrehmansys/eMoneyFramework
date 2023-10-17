//
//  FastTrackUpgradePopupViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 26/04/2023.
//

import UIKit

//protocol LivenessErrorViewControllerDelegate:AnyObject{
//    func tryAgainBtnTapped()
//    func closeBtnTapped()
//}

class FastTrackUpgradePopupViewController: BaseViewController {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var btnAgree: BaseButton!
    @IBOutlet weak var buttonNotNow: BaseButton!
    
    //weak var delegate:LivenessErrorViewControllerDelegate?
    
    var errorMsg:String = ""
    
    var isPlainError:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        
    }
    

    func setupUI(){
        self.titleLabel.font = AppFont.appSemiBold(size: .h7)
        self.detailLabel.font = AppFont.appRegular(size: .body3)
        
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        self.detailLabel.textColor = AppColor.eAnd_Grey_100
        
        self.titleLabel.text = "fasttrack_registeration".localized
        self.detailLabel.text = "fasttrack_popup_description".localized
        
        btnAgree.setTitle("agree_btntext".localized, for: .normal)
        buttonNotNow.setTitle("not_now".localized, for: .normal)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true) 
    }
    
    @IBAction func agreeTapped(_ sender: Any) {
        callUpdateDocumentApi()
    }
}

extension FastTrackUpgradePopupViewController {
    func callUpdateDocumentApi() {

        var request = UpdateDocumentRequestModel()
        
        request.previousProfileName = GlobalData.shared.loginData?.profileName
        request.profileName = GlobalData.shared.loginData?.upgradeToProfile ?? ""
        request.isSingleAccount = GlobalData.shared.loginData?.isSingleAccount
        request.pin = UserDefaultHelper.userLoginPin

        Loader.shared.showFullScreen()
        Task{
            do {
                let updateData:UpdateDocumentResponseModel? = try await ApiManager.shared.executeMultipart(OnboardingApiRouter.updateDocument(param: request))
                await MainActor.run{
                    Loader.shared.hideFullScreen()
                    if let responseData = updateData?.data  {
                        GlobalData.shared.loginData?.upgradeScreen = responseData.upgradeScreen
                        GlobalData.shared.loginData?.profileName = responseData.profileName
                        GlobalData.shared.loginData?.upgradeToProfile = responseData.upgradeToProfile
                        GlobalData.shared.userProfile = UserProfile(rawValue: responseData.profileName ?? "")
                        NotificationCenter.default.post(Notification(name: .onUpgradeFlowCompletion))
                        self.dismiss(animated: true)
                    }
                }
            } catch let error as AppError{
                await MainActor.run{
                    Loader.shared.hideFullScreen()
                    Alert.showBottomSheetError(title: error.title, message: error.errorDescription)
                }
            }
        }
    }
}
