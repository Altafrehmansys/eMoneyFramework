//
//  BillPaymentCheckoutViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import UIKit
import Kingfisher

class BillPaymentCheckoutViewController: BaseViewController {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnPay: BaseButton!
    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var nextButtonBottomContraint: NSLayoutConstraint!
    
    // MARK: Properties

    var presenter: BillPaymentCheckoutPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnPayPressed(_ sender: Any) {
        Loader.shared.showFullScreen()
        self.presenter?.navigateToSuccess()
    }
    
}

extension BillPaymentCheckoutViewController: BillPaymentCheckoutViewProtocol {
    func updatePayBtn(fees: String) {
        switch self.presenter?.billInput?.billType {
        case .mobilEtisalat,.homeDEWA,.homeISTA,.homeLootahGas,.vehicleMawaqif:
            self.btnPay.setTitle("\(Strings.BillPayment.pay) \(fees.addCurrency())", for: .normal)
        case .mobileDu:
            if self.presenter?.billInput?.isPrepaid == true {
                self.btnPay.setTitle("\(Strings.BillPayment.topUp) \(fees.addCurrency())", for: .normal)
            }else{
                self.btnPay.setTitle("\(Strings.BillPayment.pay) \(fees.addCurrency())", for: .normal)
            }
        case .ipMobile:
            self.btnPay.setTitle("\(Strings.BillPayment.recharge) \(fees.addCurrency())", for: .normal)
        case .vehicleTrafficFineDubaiPolice:
            self.btnPay.setTitle("\(Strings.BillPayment.pay_fine) \(fees.addCurrency())", for: .normal)
        case .vehicleSalik:
            self.btnPay.setTitle("\(Strings.BillPayment.topUp) \(fees.addCurrency())", for: .normal)
        default:
            self.btnPay.setTitle("\(Strings.BillPayment.continueBtnText) \(fees)", for: .normal)
        }
    }
    
    func setupUI() {
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        self.titleLabel.font = AppFont.appRegular(size: .body3)
        self.subTitle.textColor = AppColor.eAnd_Grey_100
        self.subTitle.font = AppFont.appRegular(size: .body4)
        notesLabel.textColor = AppColor.eAnd_Grey_100
        notesLabel.font = AppFont.appRegular(size: .body4)
        amountLabel.font = AppFont.appSemiBold(size: .h5)
        
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
        tblView.layer.cornerRadius = 12
        tblView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        tblView.layer.borderWidth = 1
        
        self.btnPay.type = .GradientCircleButton
        self.setupNavigatioBar()
        bindDataWithUI()
    }
    func reloadTableView() {
        let identifiers = presenter?.datasource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        self.tblView.reloadData()
    }
    private func setupNavigatioBar() {
        self.createNavBackBtn()
        self.navigationItem.setTitle(title: "\(self.presenter?.billInput?.selectedItem?.title ?? "") \(Strings.BillPayment.postpaidBill)",subtitle: "\(Strings.BillPayment.walletBalance) \(/GlobalData.shared.availableBalance?.balance?.addCurrency())",isBoldTitle: true)
    }
    
    private func bindDataWithUI(){
        let title = self.presenter?.billInput?.title
        let subTitle = self.presenter?.billInput?.subTitle
        let balance = /GlobalData.shared.availableBalance?.balance?.addCurrency()
        switch self.presenter?.billInput?.billType{
         case .vehicleTrafficFineDubaiPolice:
            self.subTitle.isHidden = true
            switch self.presenter?.billInput?.fine?.selectedType {
            case .plateNo:
                self.titleLabel.text = self.presenter?.billInput?.fine?.plateNumber.title
            case .tfcNo:
                self.titleLabel.text = self.presenter?.billInput?.fine?.tfcNumber.title
            case .licenseNo:
                self.titleLabel.text = self.presenter?.billInput?.fine?.licenseNumber.title
            case .fineNo:
                self.titleLabel.text = self.presenter?.billInput?.fine?.fineNumber.title
            default:break
            }
        case .vehicleSalik:
            self.titleLabel.text = title
            self.subTitle.text = "\(Strings.BillPayment.balance): \(balance)"
        case .osISTARegistration:
            self.titleLabel.text = "ISTA"
            self.subTitle.text = title
        default:
            if title?.isEmpty == true {
                self.titleLabel.text = subTitle
                self.subTitle.isHidden = true
            }else{
                self.titleLabel.text = title
                self.subTitle.isHidden = false
                self.subTitle.text = subTitle
            }
        }
      
        self.amountLabel.text = self.presenter?.billInput?.billDueAmount
        self.amountLabel.font = AppFont.appSemiBold(size: .h5)
        self.notesLabel.text =  self.presenter?.billInput?.enterBillAmount
        let url = URL(string: self.presenter?.billInput?.selectedItem?.imageUrl ?? "")
        self.imgView.kf.setImage(with: url)
    }
}
extension BillPaymentCheckoutViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.datasource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = presenter?.datasource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        cell.cellModel = model
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = presenter?.datasource[indexPath.row] {
            model.actions?.cellSelected(indexPath.row, model)
        }
    }
}
