//
//  BillCompleteRechargeViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 31/05/2023.
//  
//

import UIKit
import Kingfisher

class BillCompleteRechargeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var screenTitleLabel: UILabel!
    @IBOutlet private weak var providerImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userphoneLabel: UILabel!
    @IBOutlet private weak var providerNameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var purchaseCodeLabel: UILabel!
    @IBOutlet private weak var purchaseCodeContainerView: UIStackView!
    @IBOutlet private weak var purchaseCodeValueLabel: UILabel!
    @IBOutlet private weak var pinLabel: UILabel!
    @IBOutlet private weak var pinValueLabel: UILabel!
    @IBOutlet private weak var pinCodeContainerView: UIStackView!
    @IBOutlet private weak var howToUserTitleLabel: UILabel!
    @IBOutlet private weak var howToUserValueLabel: UILabel!
    @IBOutlet private weak var confirmButton: BaseButton!
    
    // MARK: Properties
    
    var presenter: BillCompleteRechargePresenterProtocol?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
        amountLabel.text = /presenter?.inputs?.billDueAmount
        usernameLabel.text = /presenter?.inputs?.title
        userphoneLabel.text = /presenter?.inputs?.accountNumber
        providerNameLabel.text = /presenter?.inputs?.selectedItem?.title
        let url = URL(string: /self.presenter?.inputs?.selectedItem?.imageUrl)
        providerImageView.kf.setImage(with: url)
        setLocalizations()
    }
    
    private func setUI() {
      //  setNavigationController()
        setNextButton()
        setFonts()
        setConfirmButton()
        addActionToPurchaseCode()
        addActionToPinCode()
    }
    
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "Complete Rechrage")
        let shareIconImage =  UIImage(named: "share-icon")?.withRenderingMode(.alwaysTemplate)
        shareIconImage?.withTintColor(AppColor.eAnd_Black_80)
        let shareButton = UIBarButtonItem(image: shareIconImage, style: .plain, target: nil, action: nil)
        shareButton.tintColor = AppColor.eAnd_Black_80
        self.navigationItem.rightBarButtonItem = shareButton
        createNavBackBtn()
    }
    
    private func setNextButton() {
        // nextButtonContainer.addGradient(colors: [AppColor.eAnd_Red_Gradient_Start, AppColor.eAnd_Red_Gradient_End], locations: [0, 1], startPoint: CGPoint(x: 0, y: 0.5), endPoint:  CGPoint(x: 1.0, y: 0.5))
        //  nextButtonContainer.clipsToBounds = true
    }
    
    private func setFonts() {
        usernameLabel.font = AppFont.appSemiBold(size: .body2)
        userphoneLabel.font = AppFont.appRegular(size: .body3)
        providerNameLabel.font = AppFont.appRegular(size: .body3)
        amountLabel.font = AppFont.appSemiBold(size: .h5)
        purchaseCodeLabel.font = AppFont.appRegular(size: .body3)
        purchaseCodeValueLabel.font = AppFont.appSemiBold(size: .body3)
        pinLabel.font = AppFont.appRegular(size: .body3)
        pinValueLabel.font = AppFont.appSemiBold(size: .body3)
        howToUserTitleLabel.font = AppFont.appRegular(size: .body3)
        howToUserValueLabel.font = AppFont.appRegular(size: .body4)
    }
    
    private func setConfirmButton() {
        confirmButton.setTitle("Return to homepage", for: .normal)
        confirmButton.type = .GradientButton
        confirmButton.titleLabel?.font = AppFont.appSemiBold(size: .body2)
    }
    
    private func setLocalizations() {
        screenTitleLabel.text = Strings.BillPayment.complete_your_charge
        confirmButton.setTitle(Strings.BillPayment.return_to_bills_top_ups, for: .normal)
        purchaseCodeLabel.text = Strings.BillPayment.purchase_code
        pinLabel.text = Strings.BillPayment.pin
        howToUserTitleLabel.text = Strings.BillPayment.howToUse
    }
    
    private func addActionToPurchaseCode() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tappedPurcahse))
        self.purchaseCodeContainerView.addGestureRecognizer(longPressRecognizer)
    }
    @objc func tappedPurcahse(sender: UITapGestureRecognizer) {
        guard let value = purchaseCodeValueLabel.text else { return }
        UIPasteboard.general.string = value
        Alert.showToast(with: Strings.Wallet.copied_to_clipboard)
        print(UIPasteboard.general.string, "copied with ")
    }
    
    private func addActionToPinCode() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tappedPin))
        self.pinCodeContainerView.addGestureRecognizer(longPressRecognizer)
    }
    @objc func tappedPin(sender: UITapGestureRecognizer) {
        guard let value = pinValueLabel.text else { return }
        UIPasteboard.general.string = value
        Alert.showToast(with: Strings.Wallet.copied_to_clipboard)
        print(UIPasteboard.general.string, "copied with ")
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        
    }
}

extension BillCompleteRechargeViewController: BillCompleteRechargeViewProtocol {
    
}
