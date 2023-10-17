//
//  TransferStatusViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class TransferStatusViewController: BaseViewController {
    // MARK: Outlets
    @IBOutlet weak var buttonReturnHomepage: BaseButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTrackingLink: UILabel!
    @IBOutlet weak var labelTransferStatus: UILabel!
    
    // MARK: Properties
    var presenter: TransferStatusPresenterProtocol?

    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "TransferStatusViewController", bundle: bundle)
        //Bundle(for: TransferStatusViewController.self))
    }
  
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(TransferStatusViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupTableView()
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
    
    
    // MARK: IB Actions
    @IBAction func buttonHomePageTapped(_ sender: Any) {
        
    }
    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TransferStatusViewController: TransferStatusViewProtocol {
    
}
// MARK: - UITableViewDataSource
extension TransferStatusViewController: UITableViewDataSource {
    
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
extension TransferStatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter?.dataSource[indexPath.row]
        model?.actions?.cellSelected(indexPath.row, model!)
    }
}
