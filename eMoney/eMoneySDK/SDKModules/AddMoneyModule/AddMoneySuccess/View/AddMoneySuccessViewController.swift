//
//  AddMoneySuccessViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 02/05/2023.
//  
//

import Foundation
import UIKit

class AddMoneySuccessViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var enableAutoAddMoneyLabel: UILabel!
    
    @IBOutlet weak var enableAutoAddMoneySwitch: CustomSwitch!
    @IBOutlet weak var amountField: BaseAmountField!
    @IBOutlet weak var returnToHomeButton: BaseButton!
    @IBOutlet weak var animationView: UIView!

    // MARK: Properties
    var presenter: AddMoneySuccessPresenterProtocol!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension AddMoneySuccessViewController: AddMoneySuccessViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
        
        titleImage.image = UIImage(named: "success_icon")
        titleLabel.text = presenter.title
        titleLabel.font = AppFont.appSemiBold(size: .h6)
        titleLabel.textColor = AppColor.eAnd_Black_80
        
        if presenter.subtitle == ""{
            subtitleLabel.isHidden = true
        }
        else{
            subtitleLabel.text = presenter.subtitle
            subtitleLabel.font = AppFont.appRegular(size: .body3)
            subtitleLabel.textColor = AppColor.eAnd_Grey_100
        }
        
        amountField.isUserInteractionEnabled = false
        amountField.currentColor = AppColor.eAnd_Black_80
        amountField.settingView(desc: "")
        
        let amount = presenter.amount.lowercased().replace(string: (Strings.Generic.currency.lowercased() + " "), replacement: "")
        let amountInDouble = (Double(amount) ?? 0.0)
        amountField.text = amountInDouble.formattedAmountWithComma
        
        returnToHomeButton.setTitle(Strings.AddMoney.retrunToHomePage, for: .normal)
        returnToHomeButton.type = .GradientButton
        returnToHomeButton.titleLabel?.font = AppFont.appSemiBold(size: .body2)
        
        enableAutoAddMoneyLabel.text = presenter.switchTitle
        enableAutoAddMoneyLabel.font = AppFont.appRegular(size: .body4)
        enableAutoAddMoneyLabel.textColor = AppColor.eAnd_Black_80
        
        enableAutoAddMoneySwitch.onTintColor = AppColor.eAnd_Red_100
        enableAutoAddMoneySwitch.offTintColor = AppColor.eAnd_Grey_50
        enableAutoAddMoneySwitch.thumbSize = CGSize(width: 20, height: 20)
        enableAutoAddMoneySwitch.thumbTintColor = .white
        enableAutoAddMoneySwitch.isOn = false
        
        enableAutoAddMoneySwitch.addTarget(self, action: #selector(switchValueChangedAction), for: .valueChanged)
        
        // Play animation
        playAnimation()
    }
    
    private func setupNavigation() {
        self.addBarButtonItemWithImage(UIImage(named: "share-icon"), .right, self, #selector(shareButtonAction))
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

// MARK: - Play Animation
extension AddMoneySuccessViewController {
    
    func playAnimation() {
        let anim = ConfittiAnimation(OnView: animationView)
        anim.play {
            
        }
    }
}

// MARK: - Actions
extension AddMoneySuccessViewController {
    @objc func switchValueChangedAction() {
        let isOn = enableAutoAddMoneySwitch.isOn ? "On" : "Off"
        print(isOn)
    }
    
    @objc func shareButtonAction() {
        presenter.shareButtonAction()
    }
    
    @IBAction func returnToHomeAction(_ sender: Any) {
        presenter.backAction()
    }
}

// MARK: - UITableViewDataSource
extension AddMoneySuccessViewController: UITableViewDataSource {
    
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
extension AddMoneySuccessViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
