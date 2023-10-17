//
//  VehiclesAndTransportDetailViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit
import DropDown

class VehiclesAndTransportDetailViewController: BaseViewController {
    @IBOutlet weak var listItemImageView: UIImageView!
    @IBOutlet weak var listItemTitle: UILabel!
    @IBOutlet weak var btnTick: UIButton!
    
    @IBOutlet weak var btnContinue: BaseButton!
    @IBOutlet weak var saveThisLabel: UILabel!
    
    @IBOutlet weak var infoTextField: StandardTextField!
    
    @IBOutlet var plateNoTFCollection: [StandardTextField]!
    @IBOutlet weak var plateNoView:UIStackView!
    
    @IBOutlet weak var tfcNoView:UIStackView!
    @IBOutlet var tfcTFCollection: [StandardTextField]!
    
    @IBOutlet weak var licenseNoView:UIStackView!
    @IBOutlet var licenseTFCollection: [StandardTextField]!
    
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var fineNoView:UIStackView!
    @IBOutlet var fineTFCollection: [StandardTextField]!
    // MARK: Properties
    private var keyboardHelper: KeyboardHelper?
    
    
    var presenter: VehiclesAndTransportDetailPresenterProtocol!
    var dropDown = DropDown()
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    func validateContinueButton() {
        if let text = self.infoTextField.text as String?,
        text.isEmpty == true{
            self.btnContinue.disable()
            return
        }else{
            self.btnContinue.enable()
        }
        switch presenter.fine.selectedType {
        case .plateNo:
            self.plateNoTFCollection.contains(where: { (/$0.text).isEmpty == true}) ? btnContinue.disable() : btnContinue.enable()
        case .tfcNo:
            self.tfcTFCollection.contains(where: { (/$0.text).isEmpty == true}) ? btnContinue.disable() : btnContinue.enable()
        case .licenseNo:
            self.licenseTFCollection.contains(where: { (/$0.text).isEmpty == true}) ? btnContinue.disable() : btnContinue.enable()
        case .fineNo:
            self.fineTFCollection.contains(where: { (/$0.text).isEmpty == true}) ? btnContinue.disable() : btnContinue.enable()
            
        }
    }
    func validateData() {
        guard let info = self.infoTextField.text as String?,
              info.isEmpty == false else {
            self.infoTextField.showError(with:Strings.BillPayment.select_information_type)
            return
        }
        switch presenter.fine.selectedType {
        case .plateNo:
            for (index,textfield) in self.plateNoTFCollection.enumerated() {
                guard let text = textfield.text as String?,
                      text.isEmpty == false else {
                    switch index{
                    case 0:
                        textfield.showError(with:Strings.BillPayment.please_select_plate_source)
                    case 1:
                        textfield.showError(with:Strings.BillPayment.please_select_plate_category)
                    case 2:
                        textfield.showError(with:Strings.BillPayment.please_enter_plate_code)
                    case 3:
                        textfield.showError(with:Strings.BillPayment.please_enter_plate_number)
                    default:return}
                return
                }
                switch index{
                case 0:
                    self.presenter.fine.plateNumber.plateCategory = text
                case 1:
                    self.presenter.fine.plateNumber.plateSource = text
                case 2:
                    self.presenter.fine.plateNumber.plateCode = text
                case 3:
                    self.presenter.fine.plateNumber.plateNumber = text
                default:return}
                textfield.hideError()
            }
    case .tfcNo:
            for (index,textfield) in self.tfcTFCollection.enumerated() {
                guard let text = textfield.text as String?,
                      text.isEmpty == false else {
                    switch index{
                    case 0:
                        textfield.showError(with:Strings.BillPayment.please_enter_TFC_number)
                    default:return}
                return
                }
                switch index{
                case 0:
                    self.presenter.fine.tfcNumber.tfcNumber = text
                default:return}
                textfield.hideError()
            }
    case .licenseNo:
            for (index,textfield) in self.licenseTFCollection.enumerated() {
                guard let text = textfield.text as String?,
                      text.isEmpty == false else {
                    switch index{
                    case 0:
                        textfield.showError(with:Strings.BillPayment.please_select_license_source)
                    case 1:
                        textfield.showError(with:Strings.BillPayment.please_enter_license_number)
                    default:return
                    }
                return
                }
                switch index{
                case 0:
                    self.presenter.fine.licenseNumber.licenseSource = text
                case 1:
                    self.presenter.fine.licenseNumber.licenseNumber = text
                default:return
                }
                textfield.hideError()
            }
        case.fineNo:
            for (index,textfield) in self.fineTFCollection.enumerated() {
                guard let text = textfield.text as String?,
                      text.isEmpty == false else {
                    switch index{
                    case 0:
                        textfield.showError(with:Strings.BillPayment.please_select_fine_source)
                    case 1:
                        textfield.showError(with:Strings.BillPayment.please_enter_fine_year)
                    case 2:
                        textfield.showError(with: Strings.BillPayment.please_enter_fine_number)
                    default:return
                    }
                    return
                }
                switch index{
                case 0:
                    self.presenter.fine.fineNumber.fineSource = text
                case 1:
                    self.presenter.fine.fineNumber.fineYear = text
                case 2:
                    self.presenter.fine.fineNumber.fineNumber = text
                default:return
                }
                textfield.hideError()
            }
    }
        self.presenter.validatePayBills()
//        self.presenter.navigateToTraficFineScreen()
}
@IBAction func btnContinuePressed(_ sender: Any) {
    self.validateData()
}
@IBAction func btnTickPressed(_ sender: Any) {
    
    self.btnTick.setImage(UIImage(named:"defaultCheckbox"), for: .normal)
    self.presenter.isSavedForFuture = !self.presenter.isSavedForFuture
    if self.presenter.isSavedForFuture {
        self.btnTick.setImage(UIImage(named:"redCheckbox"), for: .normal)
    }
}
}

extension VehiclesAndTransportDetailViewController: VehiclesAndTransportDetailViewProtocol {
    func setTextFields(_ type: VehicleFineType?) {
        self.validateContinueButton()
        self.btnTick.isHidden = type == .fineNo
        self.saveThisLabel.isHidden = type == .fineNo
        switch type {
        case .plateNo:
            self.setupPlateNo()
            self.plateNoView.isHidden = false
            self.tfcNoView.isHidden = true
            self.licenseNoView.isHidden = true
            self.fineNoView.isHidden = true
            
        case .tfcNo:
            self.setupTFCNo()
            self.plateNoView.isHidden = true
            self.tfcNoView.isHidden = false
            self.licenseNoView.isHidden = true
            self.fineNoView.isHidden = true
        case .licenseNo:
            self.setupLicense()
            self.plateNoView.isHidden = true
            self.tfcNoView.isHidden = true
            self.licenseNoView.isHidden = false
            self.fineNoView.isHidden = true
        case .fineNo:
            self.setupFineNo()
            self.plateNoView.isHidden = true
            self.tfcNoView.isHidden = true
            self.licenseNoView.isHidden = true
            self.fineNoView.isHidden = false
        case .none:
            self.setupInfoField()
            self.plateNoView.isHidden = true
            self.tfcNoView.isHidden = true
            self.licenseNoView.isHidden = true
            self.fineNoView.isHidden = true
        }
    }
    func setupInfoField(){
        self.infoTextField.placeholder = Strings.BillPayment.select_information_type
        self.infoTextField.trailingButtonImage = "arrow-down"
        self.infoTextField.textFieldDidBeginEditingCallback = { [unowned self] in
            self.showDropdown(textfield:self.infoTextField,
                              dataSource: ["Plate number", "TFC number","License number","Fine number"])
        }
        self.infoTextField.textChangedCallback = { [unowned self] in
            self.validateContinueButton()
        }
    }
    func setupPlateNo(){
        for (index,textfield) in self.plateNoTFCollection.enumerated() {
            textfield.textChangedCallback = {
                self.validateContinueButton()
            }
            textfield.textFieldFont = AppFont.appRegular(size: .body2)
            textfield.textFieldTextColor = AppColor.eAnd_Black_80
            
            switch index{
            case 0:
                textfield.title = Strings.BillPayment.enterPlateCategory
                textfield.trailingButtonImage = "arrow-down"
                textfield.textFieldDidBeginEditingCallback = {
                    if textfield.text.isEmpty {
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateCategories.map({ $0.name ?? "-"}))
                    }else{
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateCategories.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    }
                }
                textfield.textChangedCallback = { [unowned self] in
                    self.showDropdown(textfield:textfield,
                                      dataSource: self.presenter.plateCategories.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    
                }
            case 1:
                textfield.title = Strings.BillPayment.selectPlateSource
                textfield.trailingButtonImage = "arrow-down"
                textfield.textFieldDidBeginEditingCallback = {
                    if textfield.text.isEmpty {
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateSource.map({ $0.name ?? "-"}))
                    }else{
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    }
                }
                textfield.textChangedCallback = { [unowned self] in
                    self.showDropdown(textfield:textfield,
                                      dataSource: self.presenter.plateSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                }
            case 2:
                textfield.title = Strings.BillPayment.enterPlateCode
                textfield.trailingButtonImage = "arrow-down"
                textfield.textFieldDidBeginEditingCallback = {
                    if textfield.text.isEmpty {
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateCodes.map({ $0.name ?? "-"}))
                    }else{
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateCodes.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    }
                }
                textfield.textChangedCallback = { [unowned self] in
                    self.showDropdown(textfield:textfield,
                                      dataSource: self.presenter.plateCodes.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                }
            case 3:
                textfield.title = Strings.BillPayment.plateNumber
                textfield.entryType = .decimal
                textfield.textLimit = 6
            default:break
            }
            textfield.setupConfigurations()
        }
    }
    func setupTFCNo(){
        for (index,textfield) in self.tfcTFCollection.enumerated() {
            textfield.textChangedCallback = {
                self.validateContinueButton()
            }
            textfield.textFieldFont = AppFont.appRegular(size: .body2)
            textfield.textFieldTextColor = AppColor.eAnd_Black_80
            
            switch index{
            case 0:
                textfield.title = Strings.BillPayment.tfcNumber
                textfield.entryType = .decimal
                textfield.textLimit = 12
            default:break
            }
        }
    }
    func setupLicense() {
        for (index,textfield) in self.licenseTFCollection.enumerated() {
            textfield.textChangedCallback = {
                self.validateContinueButton()
            }
            textfield.textFieldFont = AppFont.appRegular(size: .body2)
            textfield.textFieldTextColor = AppColor.eAnd_Black_80
            
            switch index{
            case 0:
                textfield.title = Strings.BillPayment.licenseSource
                textfield.trailingButtonImage = "arrow-down"
                textfield.textFieldDidBeginEditingCallback = {
                    if textfield.text.isEmpty {
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.licenseSource.map({ $0.name ?? "-"}))
                    }else{
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.licenseSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    }
                }
                textfield.textChangedCallback = { [unowned self] in
                    self.showDropdown(textfield:textfield,
                                      dataSource: self.presenter.licenseSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                }
            case 1:
                textfield.title = Strings.BillPayment.licenseNumber
                textfield.entryType = .decimal
                textfield.textLimit = 8
            default:break
            }
            textfield.setupConfigurations()
        }
    }
    func setupFineNo() {
        for (index,textfield) in self.fineTFCollection.enumerated() {
            textfield.textChangedCallback = {
                self.validateContinueButton()
            }
            textfield.textFieldFont = AppFont.appRegular(size: .body2)
            textfield.textFieldTextColor = AppColor.eAnd_Black_80
            
            switch index{
            case 0:
                textfield.title = Strings.BillPayment.select_fine_source
                textfield.trailingButtonImage = "arrow-down"
                textfield.textFieldDidBeginEditingCallback = {
                    if textfield.text.isEmpty {
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.fineSource.map({ $0.name ?? "-"}))
                    }else{
                        self.showDropdown(textfield:textfield,
                                          dataSource: self.presenter.plateSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                    }
                }
                textfield.textChangedCallback = { [unowned self] in
                    self.showDropdown(textfield:textfield,
                                      dataSource: self.presenter.fineSource.filter { $0.name?.lowercased().starts(with:textfield.text.lowercased()) == true}.map {/$0.name})
                }
            case 1:
                textfield.title = Strings.BillPayment.enter_fine_year
                textfield.entryType = .decimal
                textfield.textLimit = 4
            case 2:
                textfield.title = Strings.BillPayment.enter_fine_no
                textfield.entryType = .decimal
                textfield.textLimit = 12
            default:break
            }
            textfield.setupConfigurations()
        }
    }
    func showDropdown(textfield:StandardTextField,dataSource:[String]) {
        if textfield == self.infoTextField {
            textfield.resignFirstResponder()
        }
        dropDown.anchorView = textfield
        dropDown.bottomOffset = CGPoint(x:0, y: textfield.frame.height + 8)
        dropDown.cellHeight = 70
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
            textfield.resignFirstResponder()
        }
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCell else { return }
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        dropDown.selectionAction = { (index,item) in
            textfield.text = item
            textfield.resignFirstResponder()
            textfield.hideError()
            if textfield == self.infoTextField {
                self.presenter.reloadTextFields(VehicleFineType(rawValue: item) ?? .none)
            }
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
    }
    func setupUI() {
        keyboardHelper = KeyboardHelper { [unowned self] animation, keyboardFrame, duration in
            switch animation {
            case .keyboardWillShow:
                nextButtonBottomConstraint.constant = keyboardFrame.height
            case .keyboardWillHide:
                nextButtonBottomConstraint.constant = 32
            }
        }
        btnContinue.setTitle(Strings.BillPayment.continueToPayFine, for: .normal)
        btnContinue.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        btnContinue.type = .GradientButton
        self.btnTick.setImage(UIImage(named:"redCheckbox"), for: .normal)
        self.setupTableView()
        view.backgroundColor = .white
        setUpNavbar()
        self.listItemTitle.text = self.presenter.selectedItem?.title
        self.listItemTitle.font = AppFont.appSemiBold(size: .body2)
        self.listItemTitle.textColor = AppColor.eAnd_Black_80
        if let url = URL(string:self.presenter.selectedItem?.imageUrl ?? "") {
            self.listItemImageView.load(url: url)
        }
    }
    
    func reloadData() {
    }
    
    private func setupTableView() {
    }
    private func setUpNavbar(){
        self.navigationItem.setTitle(title:self.presenter.navTitle,subtitle:Strings.BillPayment.carDetails)
        self.createNavBackBtn()
    }
}
