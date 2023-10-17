//
//  AddNewCardViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 05/05/2023.
//  
//

import Foundation
import UIKit

class AddNewCardViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveCardButton: BaseButton!
    let toolTip = ToolTipVC()
    let toolTipView = ToolTipView.fromNib()
    
    // MARK: Properties
    var presenter: AddNewCardPresenterProtocol!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

// MARK: - Class Methods
extension AddNewCardViewController: AddNewCardViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
        showToolTipView()
        
        saveCardButton.type = .GradientButton
        saveCardButton.cornerRadius = 24
        saveCardButton.setTitle(Strings.AddMoney.saveCard, for: .normal)
        saveCardButton.addTarget(self, action: #selector(saveCardTappedAction(_:)), for: .touchUpInside)
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: Strings.AddMoney.addNewCard)
        self.createNavBackBtn()
        
        self.addBarButtonItemWithImage(UIImage(named: "camera"), .right, self, #selector(scanCardTappedAction))
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 10, right: 0)
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
}

// MARK: - Actions
extension AddNewCardViewController {
    @objc func saveCardTappedAction(_ sender: BaseButton) {
        
    }
    
    @objc func scanCardTappedAction() {
        presenter.navigateToScanCard()
    }
    
    @objc func dismissPop() {
        toolTip.dismiss(animated: true, completion: nil)
    }
    
    func showToolTipView(){
        if !UserDefaultHelper.toolTipFirstTimeShow {
            UserDefaultHelper.toolTipFirstTimeShow = true
            toolTipView.btnClose.addTarget(self, action: #selector(dismissPop), for: .touchUpInside)
            
            //setupUI For Cell
            toolTipView.lblTitle.text = Strings.AddMoney.scanYourCard
            toolTipView.lblTitle.font = AppFont.appRegular(size: .body3)
            toolTipView.lblTitle.textColor = AppColor.eAnd_Black_80
            toolTipView.backgroundColor = AppColor.eAnd_Best_seller_light
            toolTipView.scanImg.image = UIImage(named: "scan")
            toolTipView.btnClose.setBackgroundImage(UIImage(named: "cross"), for: .normal)

            if let customView = self.navigationItem.rightBarButtonItem?.customView {
                toolTip.showToolTip(onItem: customView, cmView: toolTipView, arrowDirection: .up, viewSize: CGSize(width: CGFloat(self.view.frame.width - 30), height: CGFloat(72)))
                present(toolTip, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension AddNewCardViewController: UITableViewDataSource {
    
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
extension AddNewCardViewController: UITableViewDelegate {
    
}

extension AddNewCardViewController: AddMoneyScanCardRouterOutputProtocol {
    func didReturnCardData(_ details: CardDetails) {
        presenter.updateData(with: details)
    }
}
