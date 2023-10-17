//
//  SendAbroadViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation
import UIKit

class SendAbroadViewController: BaseViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: SendAbroadPresenterProtocol?

    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "SendAbroadViewController", bundle: bundle)
        //Bundle(for: SendAbroadViewController.self))
    }
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(SendAbroadViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        createNavBackBtn()
        self.navigationItem.setTitle(title: "send_abroad".localized)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func reloadData() {
        let identifiers = presenter?.dataSource.map { $0.reusableIdentifier() }
        identifiers!.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
}
extension SendAbroadViewController: SendAbroadViewProtocol {
    
}

// MARK: - UITableViewDataSource
extension SendAbroadViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.dataSource.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter?.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model?.reusableIdentifier() ?? "") as? StandardCell else {
            return UITableViewCell()
        }
        if model !== cell.cellModel {
            cell.cellModel = model
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate
extension SendAbroadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter?.dataSource[indexPath.row]
        model?.actions?.cellSelected(indexPath.row, model!)
    }
}
