//
//  BillPaymentSuccessViewController.swift
//  e&money
//
//  Created by Usama Zahid Khan on 05/06/2023.
//  
//

import Foundation
import UIKit
import Lottie

class BillPaymentSuccessViewController: BaseViewController {
    @IBOutlet weak var successAnimatedTickView:LottieAnimationView!
    @IBOutlet weak var animatedBGView:LottieAnimationView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var headingLabel:UILabel!
    
    @IBOutlet weak var btnReturn: BaseButton!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var autoPaymentLabel:UILabel!
    @IBOutlet weak var autoPaymentSwitch:UISwitch!
    @IBOutlet weak var autoPaymentView:UIView!
    @IBOutlet weak var topEarnedView: UIView!
    @IBOutlet weak var topEarnedLabel: UILabel!
    
    @IBOutlet weak var bottomEarnedCashLabel: UILabel!
    @IBOutlet weak var bottomEarnedCashView: UIView!
    // MARK: Properties
    @IBOutlet weak var completeRechargeContainerView: UIView!
    
    var presenter: BillPaymentSuccessPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        self.setAnimation(self.animatedBGView,
                            name: "confitti")
        self.setAnimation(self.successAnimatedTickView,
                            name: "tick-circle",
                          loopMode: .repeat(2))
      //  completeRechargeContainerView.isHidden = true
    }
    func setAnimation(_ animatedView:LottieAnimationView,
                        name:String,
                        loopMode:LottieLoopMode = .loop){
        animatedView.animation = LottieAnimation.named(name)
        animatedView.contentMode = animatedView == self.animatedBGView ? .scaleAspectFit : .scaleAspectFill
        animatedView.loopMode = .repeat(3)
        animatedView.play()
    }
    
    @IBAction func completeChargeButtonTapped(_ sender: Any) {
        presenter?.completeRechargeTapped()
    }
    @IBAction func didTapReturn(_ sender:UIButton) {
        self.isHideNavigation(false)
        self.dismiss(animated: true) {
            self.presenter?.input?.isSavedBill.toggle()
            if self.presenter?.input?.isSavedBill == true {
                SaveAutoPaymentBottomSheet.shared.present {
                    ActivateAutoRechargePrompt.shared.present {
                        UIApplication.getTopViewController()?.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }else{
                UIApplication.getTopViewController()?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension BillPaymentSuccessViewController: BillPaymentSuccessViewProtocol {
    func showCompleteRecharge() {
        completeRechargeContainerView.isHidden = false
    }
    
    func update(amount: String, currency: String) {
        self.headingLabel.text = "\(currency) \(amount)"
    }
    
    func setupUI() {
        
        
        self.autoPaymentView.isHidden = self.presenter?.hideAutoSave == true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 12
        tableView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        tableView.layer.borderWidth = 1
        
        self.btnReturn.type = .GradientCircleButton
        self.btnReturn.setTitle(Strings.BillPayment.return_to_bills_top_ups, for: .normal)
        
        self.titleLabel.text = Strings.BillPayment.payment_successful
        self.titleLabel.textColor = AppColor.eAnd_Black_80
        self.titleLabel.font = AppFont.appSemiBold(size: .h7)
        
        self.headingLabel.text = self.presenter?.input?.billDueAmount?.addCurrency()
        self.headingLabel.textColor = AppColor.eAnd_Black_80
        self.headingLabel.font = AppFont.appSemiBold(size: .h5)
        self.isHideNavigation(true)
    
        topEarnedView.layer.cornerRadius = 12
        bottomEarnedCashView.layer.cornerRadius = 12
        topEarnedLabel.text = "\(Strings.BillPayment.yourEarned) AED 100 \(Strings.BillPayment.e_and_moneyRewardsForTransfer)"
        topEarnedLabel.textColor = AppColor.eAnd_Black_80
        topEarnedLabel.font = AppFont.appRegular(size: .body4)
        bottomEarnedCashLabel.text = "\(Strings.BillPayment.yourEarned) AED 2.00 \(Strings.BillPayment.in_cashback)"
        bottomEarnedCashLabel.textColor = AppColor.eAnd_Black_80
        bottomEarnedCashLabel.font = AppFont.appRegular(size: .body4)
        
        
        autoPaymentLabel.text = Strings.BillPayment.activateAutoPaymentForThisBiller
        
    }
    func reloadTableView() {
        let identifiers = presenter?.datasource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        self.tableView.reloadData()
    }
    
}

extension BillPaymentSuccessViewController:UITableViewDelegate,UITableViewDataSource {
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
        if let model = presenter?.datasource[indexPath.row] as? CollapsableTitleTableViewCellModel {
            model.actions?.cellSelected(indexPath.row, model)
        }
    }
}
