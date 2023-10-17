//
//  SendMoneyDEWASuccessViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 10/05/2023.
//  
//

import Foundation
import UIKit

class SendMoneyDEWASuccessViewController: BaseViewController {

    @IBOutlet weak var successImgView: UIImageView!
    @IBOutlet weak var tblView: ContentSizedTableView!
    @IBOutlet weak var btnHome: BaseButton!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTransationSuccess: UILabel!
    @IBOutlet weak var pointsParentView: UIView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var cashParentView: UIView!
    @IBOutlet weak var cashLabel: UILabel!
    
    // MARK: Properties
    var presenter: SendMoneyDEWASuccessPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    @IBAction func btnMoveToHomePressed(_ sender: Any) {
        self.presenter.moveToHomeScreen()
    }
    @IBAction func btnSharePressed(_ sender: Any) {
    }
}

extension SendMoneyDEWASuccessViewController: SendMoneyDEWASuccessViewProtocol {
   
    func setUpUI() {
        
        setupTableView()
        successImgView.image = UIImage(named: "success-tick")
        pointsParentView.layer.cornerRadius = 12
        cashParentView.layer.cornerRadius = 12
        lblAmount.text = "Transfer successful"
        lblAmount.textColor = AppColor.eAnd_Black_80
        lblAmount.font = AppFont.appSemiBold(size: .h7)
        
        lblTransationSuccess.text = "AED 60.00"
        lblTransationSuccess.textColor = AppColor.eAnd_Black_80
        lblTransationSuccess.font = AppFont.appSemiBold(size: .h5)
        
        pointsLabel.text = "You have earned 100 e& points for this transfer"
        pointsLabel.textColor = AppColor.eAnd_Black_80
        pointsLabel.font = AppFont.appRegular(size: .body4)
        
        cashLabel.text = "You have earned AED 2.00 in cashback"
        cashLabel.textColor = AppColor.eAnd_Black_80
        cashLabel.font = AppFont.appRegular(size: .body4)
        
        btnHome.setTitle("Return to homepage", for: .normal)
        btnHome.type = .GradientButton
        btnHome.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
//        cashParentView.isHidden = true
//        pointsParentView.isHidden = true
        
    }
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
        
        tblView.layer.borderColor = AppColor.eAnd_Grey_20.cgColor
        tblView.layer.borderWidth = 1
        tblView.cornerRadius = 12
    }
    func reloadData() {
        
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
        tblView.layoutIfNeeded()
    }

}

// MARK: - UITableViewDataSource
extension SendMoneyDEWASuccessViewController: UITableViewDataSource {
    
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
extension SendMoneyDEWASuccessViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
