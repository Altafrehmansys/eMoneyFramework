//
//  AddBillsEnterAmountViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 22/05/2023.
//  
//

import Foundation
import UIKit
import Kingfisher
class AddBillsEnterAmountViewController: BaseViewController {

    // MARK: Properties

    @IBOutlet weak var btnNext: BaseButton!
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var amountTextField: BaseAmountField!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var presenter: AddBillsEnterAmountPresenterProtocol!
    private var keyboardHelper: KeyboardHelper?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnNextPressed(_ sender: Any) {
        switch( self.presenter.inPutParameters?.billType){
        case .mobilEtisalat,.homeDEWA,.homeISTA, .homeLootahGas, .osISTARegistration,.vehicleTrafficFineDubaiPolice,.vehicleMawaqif,.mobileDu,.homeSEWA,.homeAADC,.homeADDC,.homeEtihadWaterAndElectricity,.homeAjmanSewerage,.homeSERGAS,.govtAjmanPay,.osNationalbonds:
            self.amountValidation()
        default:
            break
        }
    }
    
    func amountValidation(){
        self.presenter.inPutParameters?.enterBillAmount = notesTextField.text
        self.presenter.inPutParameters?.billDueAmount = amountTextField.amount?.addCurrency()
        self.presenter.navigateToBillCheckOutScreen()
    }
}

extension AddBillsEnterAmountViewController: AddBillsEnterAmountViewProtocol {
    
    func setupUI() {
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        self.titleLabel.font = AppFont.appRegular(size: .body3)
        self.subTitleLabel.textColor = AppColor.eAnd_Grey_70
        self.subTitleLabel.font = AppFont.appRegular(size: .body4)
        amountTextField.textChangedCallback = {
            let amount = /self.amountTextField.amount?.toDouble()
            let min = /self.presenter.inPutParameters?.billMin.toDouble()
            let max = /self.presenter.inPutParameters?.billMax.toDouble()
            if((amount < min)  || (amount > max)) {
                self.btnNext.disable()
                self.amountTextField.labelDescription.isHidden = false
                self.amountTextField.labelDescription.text  = "Invalid amount entered"
            }else{
                self.btnNext.enable()
                self.amountTextField.labelDescription.isHidden = true
            }
        }
        amountTextField.labelDescription.font = AppFont.appRegular(size: .body4)
        amountTextField.labelDescription.textColor = AppColor.eAnd_Error_100
        
        amountTextField.textfieldFonts = [AppFont.appLight(size: .h4),AppFont.appLight(size: .h4)]
        notesTextField.textColor = AppColor.eAnd_Grey_100
        notesTextField.font = AppFont.appRegular(size: .body4)
        setUpNavbar()
        bindDataWithUI()
        amountTextField.fieldTypeEnum = .enable
        amountTextField.currentColor = AppColor.eAnd_Black_80
        amountTextField.settingView(desc: "")
        amountTextField.becomeFirstResponder = true
        keyboardHelper = KeyboardHelper { [unowned self] animation, keyboardFrame, duration in
            switch animation {
            case .keyboardWillShow:
                nextButtonHeightConstraint.constant = keyboardFrame.height
            case .keyboardWillHide:
                nextButtonHeightConstraint.constant = 24
            }
        }
    }
   
    func updateDefaultAmout(value: String) {
        self.amountTextField.text = value
        let amount = /self.amountTextField.amount?.toDouble()
        let min = /self.presenter.inPutParameters?.billMin.toDouble()
        let max = /self.presenter.inPutParameters?.billMax.toDouble()
        ((amount < min)  || (amount > max)) ? self.btnNext.disable() : self.btnNext.enable()
    }
    
    func updateNotes(text: String) {
        self.notesTextField.text = text
    }
    private func setUpNavbar(){

        self.navigationItem.setTitle(title: "\(self.presenter.inPutParameters?.selectedItem?.title ?? "") - \(Strings.BillPayment.postpaidBill)",subtitle: "\(Strings.BillPayment.walletBalance) \(/GlobalData.shared.availableBalance?.balance?.addCurrency())",isBoldTitle: true)
        self.createNavBackBtn()
        
    }
    private func bindDataWithUI(){
        let title = self.presenter.inPutParameters?.title
        let subtitle = self.presenter.inPutParameters?.subTitle
        let balance = /GlobalData.shared.availableBalance?.balance?.addCurrency()
        switch self.presenter.inPutParameters?.billType{
        case .vehicleTrafficFineDubaiPolice:
            self.subTitleLabel.isHidden = true
            if self.presenter.inPutParameters?.fine?.plateNumber != nil{
                if let placeSource = self.presenter.inPutParameters?.fine?.plateNumber.plateSource,
                   let plateCode = self.presenter.inPutParameters?.fine?.plateNumber.plateCode {
                    self.titleLabel.text = "\(placeSource) \(plateCode)"
                }
            }
        case .vehicleSalik:
            self.titleLabel.text = title
            self.subTitleLabel.text = "\(Strings.BillPayment.balance): \(balance)"
        case .osISTARegistration:
            self.titleLabel.text = "ISTA"
            self.subTitleLabel.text = title
        default:
            if title?.isEmpty == true {
                self.titleLabel.text = subtitle
                self.subTitleLabel.isHidden = true
            }else{
                self.titleLabel.text = title
                self.subTitleLabel.isHidden = false
                self.subTitleLabel.text = subtitle
            }
        }
        
        let url = URL(string: self.presenter.inPutParameters?.selectedItem?.imageUrl ?? "")
        self.imgView.kf.setImage(with: url)
    
    }
}

