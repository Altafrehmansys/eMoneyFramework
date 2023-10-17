//
//  AddNewVehicleViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 01/06/2023.
//  
//

import Foundation
import UIKit

class AddNewVehicleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var stackActions: UIStackView!
    @IBOutlet weak var bottomMarginConstraint: NSLayoutConstraint!
    
    // MARK: Properties

    var presenter: AddNewVehiclePresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
}

extension AddNewVehicleViewController: AddNewVehicleViewProtocol {
    func setupUI() {
        self.addGesture()
        self.setupTableView()
        
        view.backgroundColor = .clear
        backgroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        
        mainContainerView.layer.cornerRadius = 20.0
        mainContainerView.layer.masksToBounds = true
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addActions()
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource?.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle:  Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tableView.layoutIfNeeded()
        }
        setupHeightConstraint()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupHeightConstraint() {
        tableViewHeightConstraint.constant = tableView.intrinsicContentSize.height
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func addActions() {
        if let actions = presenter.actions {
            actions.forEach { action in
                self.stackActions.addArrangedSubview(action)
            }
        }
    }
    
}


// MARK: - Actions
extension AddNewVehicleViewController {
    @objc func dismissView() {
        presenter.dismissView()
    }
    
}

// MARK: - UITableViewDataSource
extension AddNewVehicleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource?[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "StandardCell") as? StandardCell else {
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
extension AddNewVehicleViewController: UITableViewDelegate {
    
}
