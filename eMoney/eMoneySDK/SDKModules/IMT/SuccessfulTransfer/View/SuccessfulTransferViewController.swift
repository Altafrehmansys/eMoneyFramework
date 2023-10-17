//
//  SuccessfulTransferViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SuccessfulTransferViewController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var buttonReturnHome: BaseButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    var presenter: SuccessfulTransferPresenterProtocol?
    
    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "SuccessfulTransferViewController", bundle: bundle)
        //Bundle(for: SuccessfulTransferViewController.self))
    }
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
    
    func setViewInterfaceAndText(){
        self.addBarButtonItemWithImage(UIImage(named:"share-icon"), .right, self, #selector(shareTapped))
        buttonReturnHome.setTitle("return_to_home_page_btn_text".localized, for: .normal)
    }
    @objc func shareTapped() {
        print("shareTapped")
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(SuccessfulTransferViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupTableView()
        setViewInterfaceAndText()
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
    @IBAction func buttonReturnHomeTapped(_ sender: Any) {
        presenter?.routeToHomepage()
    }
    
    @IBAction func buttonShareTapped(_ sender: Any) {
    }
}

extension SuccessfulTransferViewController: SuccessfulTransferViewProtocol {
    
}

// MARK: - UITableViewDataSource
extension SuccessfulTransferViewController: UITableViewDataSource {
    
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
extension SuccessfulTransferViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter?.dataSource[indexPath.row]
        model?.actions?.cellSelected(indexPath.row, model!)
    }
}
