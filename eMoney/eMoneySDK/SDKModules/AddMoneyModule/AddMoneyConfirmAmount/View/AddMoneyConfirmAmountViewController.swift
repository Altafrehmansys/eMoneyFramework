//
//  AddMoneyConfirmAmountViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneyConfirmAmountViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var selectedBankLogoImageView: UIImageView!
    @IBOutlet weak var selectedBankNameLabel: UILabel!
    @IBOutlet weak var selectedBankAccountNumberLabel: UILabel!
    
    @IBOutlet weak var amountField: BaseAmountField!
    @IBOutlet weak var addButton: BaseButton!
    
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var disclaimerImg: UIImageView!
    // MARK: Properties
    var presenter: AddMoneyConfirmAmountPresenterProtocol!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.loadData()
    }
    
}

extension AddMoneyConfirmAmountViewController: AddMoneyConfirmAmountViewProtocol {
    func setupUI() {
        setupNavigation()
        setupTableView()
        
        selectedBankNameLabel.text = presenter.title
        selectedBankNameLabel.font = AppFont.appRegular(size: .body3)
        selectedBankNameLabel.textColor = AppColor.eAnd_Black_80
        
        if presenter.logo.contains("http"), let url = URL(string: presenter.logo) {
            selectedBankLogoImageView.load(url: url)
        } else {
            selectedBankLogoImageView.image = UIImage(named: presenter.logo)
        }
        
        selectedBankAccountNumberLabel.isHidden = presenter.subtitle.isEmpty
        selectedBankAccountNumberLabel.text = presenter.subtitle
        selectedBankAccountNumberLabel.font = AppFont.appRegular(size: .body4)
        selectedBankAccountNumberLabel.textColor = AppColor.eAnd_Grey_100
        
        amountField.isUserInteractionEnabled = false
        amountField.currentColor = AppColor.eAnd_Black_80
        amountField.settingView(desc: "")
        amountField.text = presenter.amount
        
        addButton.type = .GradientButton
        let buttonTitle = presenter.currentFlow.buttonTitle + " " + presenter.amount
        addButton.setTitle(buttonTitle, for: .normal)
        addButton.setTitleColor(AppColor.eAnd_White, for: .normal)
        addButton.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
        notificationTitleLabel.text = presenter.currentFlow == .bankAcount ? Strings.AddMoney.paymentGatewayDescription : Strings.AddMoney.creditCardFeesApplicableDesc
        notificationTitleLabel.font = AppFont.appRegular(size: .body4)
        notificationTitleLabel.textColor = AppColor.eAnd_Black_80
        
        if presenter.currentFlow == .debitCard{
            disclaimerImg.image = UIImage(named: "moneyGreen")
        }
        
        notificationView.backgroundColor = AppColor.eAnd_Success_10
        notificationView.cornerRadius = 12
        
        notificationView.isHidden = true
        tableView.isHidden = presenter.currentFlow != .cashAdvance
    }
    
    private func setupNavigation() {
        let walletBalance = (GlobalData.shared.availableBalance?.balance ?? 0.0).formattedAmountWithComma
        let subtitle = Strings.AddMoney.walletBalance + " " + Strings.Generic.currency + " " + walletBalance
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: subtitle, isBoldTitle: true)
        self.createNavBackBtn()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        tableView.layer.borderWidth = 1
        tableView.cornerRadius = 12
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
}

// MARK: - Actions
extension AddMoneyConfirmAmountViewController {
    @IBAction func edtiButtonTappedAction(_ sender: BaseButton) {
        presenter.goBack()
    }
    
    @IBAction func nextButtonTappedAction(_ sender: BaseButton) {
        if checkFor5000Amount() {
            presenter.loadOTPScreen(msisdn: GlobalData.shared.msisdn ?? "", addingText: Strings.AddMoney.adding, amount: presenter.amount, toTitle: Strings.AddMoney.toEMoneyWallet)
        }
        else{
            presenter.nextButtonTapped()
        }
    }
    
    func checkFor5000Amount() -> Bool {
        let amountString = presenter.amount
        let numericString = amountString.replacingOccurrences(of: "[^0-9.]", with: "", options: .regularExpression)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        let amount = numberFormatter.number(from: numericString)?.decimalValue ?? 0
        let amountToCheck = Decimal(GlobalData.shared.addMoneyMetaDataResponse?.data?.denominations?.addMoneyAmountRequireOtp ?? 0.0)
        return amount >= amountToCheck
    }

}

// MARK: - UITableViewDataSource
extension AddMoneyConfirmAmountViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension AddMoneyConfirmAmountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}


extension AddMoneyConfirmAmountViewController: OtpPopupDelegate {
    func otpPopupDidDismiss() {
        presenter.nextButtonTapped()
    }
}
