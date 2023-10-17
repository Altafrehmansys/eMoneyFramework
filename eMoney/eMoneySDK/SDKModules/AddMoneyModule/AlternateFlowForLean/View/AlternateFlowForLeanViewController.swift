//
//  AlternateFlowForLeanViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 22/06/2023.
//  
//

import Foundation
import UIKit

class AlternateFlowForLeanViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    // MARK: Properties
    var presenter: AlternateFlowForLeanPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension AlternateFlowForLeanViewController: AlternateFlowForLeanViewProtocol {
    func setupUI() {
        self.addGesture()
        self.setupTableView()
        
        view.backgroundColor = .clear
        backgroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        
        mainContainerView.layer.cornerRadius = 20.0
        mainContainerView.layer.masksToBounds = true
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
        tableView.layoutIfNeeded()
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
}


// MARK: - Actions
extension AlternateFlowForLeanViewController {
    @objc func dismissView() {
        presenter.dismissView()
    }
    
    @IBAction func crossButtonTappedAction(_ sender: UIButton) {
        presenter.dismissView()
    }
}

// MARK: - UITableViewDataSource
extension AlternateFlowForLeanViewController: UITableViewDataSource {
    
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
extension AlternateFlowForLeanViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
