//
//  SummaryViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SummaryViewController: BaseViewController,SummaryViewProtocol {

    // MARK: Outlets
    @IBOutlet weak var viewProgress: BaseStepper!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonConfirm: BaseButton!
    @IBOutlet weak var buttonSaveLater: UIButton!
    // MARK: Properties

    var presenter: SummaryPresenterProtocol?
    var isOtpEntered = false

    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "SummaryViewController", bundle: bundle)
        //Bundle(for: SummaryViewController.self))
    }
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()

    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(AddRecipentViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        createNavBackBtn()
        self.navigationItem.setTitle(title: "summary".localized, subtitle: "wallet_balance".localized)
        viewProgress.addRedLine(noOfSteps: 3, currentStep: 2)
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
    // MARK: - IB Actions
    
    @IBAction func buttonConfirmTapped(_ sender: Any) {
        
        if !isOtpEntered {
            isOtpEntered = !isOtpEntered
            presenter?.navigateToOtpOnConfirmTapped()
        }
        else {
            presenter?.navigateToSuccessTransfer()
        }
    }
    @IBAction func buttonSaveLaterTapped(_ sender: Any) {
        
    }
}

// MARK: - UITableViewDataSource
extension SummaryViewController: UITableViewDataSource {
    
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
extension SummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter?.dataSource[indexPath.row]
        model?.actions?.cellSelected(indexPath.row, model!)
    }
}

