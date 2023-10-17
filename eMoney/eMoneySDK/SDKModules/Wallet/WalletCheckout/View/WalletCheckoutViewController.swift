//
//  WalletCheckoutViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 30/05/2023.
//  
//

import UIKit
import Kingfisher

class WalletCheckoutViewController: BaseViewController {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnPay: BaseButton!
    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    
    // MARK: Properties

    var presenter: WalletCheckoutPresenterProtocol?

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

extension WalletCheckoutViewController: WalletCheckoutViewProtocol {
    func updatePayBtn(fees: String) {
        self.btnPay.setTitle("\(Strings.BillPayment.topUp) \(fees)", for: .normal)
    }
    
    func setupUI() {
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
        self.btnPay.setTitle("\(Strings.BillPayment.topUp) AED 55.50", for: .normal)
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
        self.navigationItem.setTitle(title: "\(self.presenter?.billInput?.selectedItem?.title ?? "") \(Strings.BillPayment.postpaidBill)",subtitle: "\(Strings.BillPayment.walletBalance)AED \(GlobalData.shared.availableBalance?.balance ?? 0.0)")
    }
    
    private func bindDataWithUI(){
        switch self.presenter?.billInput?.billType{
         case .vehicleTrafficFineDubaiPolice:
            self.subTitle.isHidden = true
//            if self.presenter?.billInput?.traficFineDubaiPolice?.plateNumber != nil{
//                if let placeSource = self.presenter?.billInput?.traficFineDubaiPolice?.plateNumber.placeSource,let plateCode = self.presenter?.billInput?.traficFineDubaiPolice?.plateNumber.plateCode {
//                    self.titleLabel.text = "\(placeSource) \(plateCode)"
//                }
//            }

        default:
            self.subTitle.isHidden = false
            self.subTitle.text = self.presenter?.billInput?.subTitle
            self.titleLabel.text = self.presenter?.billInput?.title
        }
      
        self.amountLabel.text = self.presenter?.billInput?.billDueAmount
        self.amountLabel.font = AppFont.appSemiBold(size: .h5)
        self.notesLabel.text =  self.presenter?.billInput?.enterBillAmount
        let url = URL(string: self.presenter?.billInput?.selectedItem?.imageUrl ?? "")
        self.imgView.kf.setImage(with: url)
    }
}
extension WalletCheckoutViewController:UITableViewDelegate,UITableViewDataSource {
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
