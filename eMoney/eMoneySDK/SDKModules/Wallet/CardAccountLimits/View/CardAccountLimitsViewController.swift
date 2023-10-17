//
//  CardAccountLimitsViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 17/07/2023.
//  
//

import Foundation
import UIKit

class CardAccountLimitsViewController: BaseViewController {
    @IBOutlet weak var btnSaveChanges: BaseButton!
    
    @IBOutlet weak var tblView: UITableView!
    // MARK: Properties

    var presenter: CardAccountLimitsPresenterProtocol!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUpNavBar()
    }
    private func setUpNavBar(){
        self.navigationItem.setTitle(title:"Manage card")
        self.createNavBackBtn()
    }
    
    @IBAction func btnSaveChanges(_ sender: Any) {
    }
    
}

extension CardAccountLimitsViewController: CardAccountLimitsViewProtocol {
    
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
extension CardAccountLimitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
        guard let cell = tblView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
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
extension CardAccountLimitsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
