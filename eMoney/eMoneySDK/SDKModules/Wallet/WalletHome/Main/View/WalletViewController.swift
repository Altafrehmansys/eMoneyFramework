//
//  WalletViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/07/2023.
//  
//

import Foundation
import UIKit

class WalletViewController: BaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnSavedAccounts: UIButton!
    @IBOutlet weak var btnEAndMoney: UIButton!
    
    
//    private var eAndMoneyAccounts: UIViewController {
//        return EAndMoneyAccountsRouter.setupModule()
//    }
//    private var savedAccounts: UIViewController {
//        return WalletSavedAccountRouter.setupModule()
//    }
    
    // MARK: Properties

    var presenter: WalletPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpTopViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isHideNavigation(true)
    }
    
    private func setUpTopViewUI(){
        accountLabel.text = Strings.Wallet.wallet_accounts
        accountLabel.font = AppFont.appSemiBold(size: .body1)
        accountLabel.textColor = AppColor.eAnd_White
        topView.addGradient(colors: [AppColor.eAnd_Red_Gradient_Start, AppColor.eAnd_Red_Gradient_End], locations: [0, 1], startPoint: CGPoint(x: 0, y: 0), endPoint:  CGPoint(x: 0, y: 1))
        btnSavedAccounts.tintColor = AppColor.eAnd_White
        setUpEAndMoneyButton(isSelected: true)
        
      //  self.add(self.eAndMoneyAccounts,view: containerView)

        
    }
    
    @IBAction func btnEAndMoneyPressed(_ sender: Any) {
        
        setUpSavedAccountButton(isSelected: false)
        setUpEAndMoneyButton(isSelected:true)
        self.presenter.eAndMoneyAccountsDataSource()
        
    }
    @IBAction func btnSavedAccountsPressed(_ sender: Any) {
        
        setUpSavedAccountButton(isSelected: true)
        setUpEAndMoneyButton(isSelected: false)
        self.presenter.savedAccountsDataSource()
    }
    
    private func setUpEAndMoneyButton(isSelected:Bool){
        
        if isSelected{
            
            btnEAndMoney.backgroundColor = AppColor.eAnd_White
            btnEAndMoney.cornerRadius = 16
            btnEAndMoney.titleLabel?.textColor = AppColor.eAnd_Red_100
            btnEAndMoney.titleLabel?.font = AppFont.appMedium(size: .body4)
            btnEAndMoney.tintColor = AppColor.eAnd_Red_100
            
        }else{
            btnEAndMoney.backgroundColor = .clear
            btnEAndMoney.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnEAndMoney.titleLabel?.textColor = AppColor.eAnd_White
            btnEAndMoney.tintColor = AppColor.eAnd_White
        }
        
    }
    private func setUpSavedAccountButton(isSelected:Bool){
        if isSelected{
            btnSavedAccounts.backgroundColor = AppColor.eAnd_White
            btnSavedAccounts.cornerRadius = 16
            btnSavedAccounts.titleLabel?.textColor = AppColor.eAnd_Red_100
            btnSavedAccounts.titleLabel?.font = AppFont.appMedium(size: .body4)
            btnSavedAccounts.setTitle(Strings.Wallet.savedAccounts, for: .normal)
            btnSavedAccounts.tintColor = AppColor.eAnd_Red_100
            
        }else{
            btnSavedAccounts.backgroundColor = .clear
            btnSavedAccounts.titleLabel?.font = AppFont.appRegular(size: .body4)
            btnSavedAccounts.titleLabel?.textColor = AppColor.eAnd_White
            btnSavedAccounts.setTitle(Strings.Wallet.savedAccounts, for: .normal)
            btnSavedAccounts.tintColor = AppColor.eAnd_White
        }
    }
}

extension WalletViewController: WalletViewProtocol {
    
    func setupUI() {
        setupTableView()
    }

    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource
extension WalletViewController: UITableViewDataSource {
    
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
extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
