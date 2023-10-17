//
//  RegistrationMethodsViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

final class RegistrationMethodsViewController: BaseViewController, RegistrationMethodsViewProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notNowBtn: BaseButton!
    
    // MARK: - Attributes
    var presenter: RegistrationMethodsPresenterProtocol!
    
    
    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "RegistrationMethodsViewController", bundle: bundle)
        //Bundle(for: RegistrationMethodsViewController.self))
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.lookupRequestToServer(lookupType: "REGISTRATION_METHOD")
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(RegistrationMethodsViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupNavBar()
        setupTableView()
        notNowBtn.setTitle("not_now".localized, for: .normal)
    }
    
    private func setupNavBar() {
        createNavBackBtn()
        self.navigationItem.setTitle(title: "register".localized, subtitle: "select_method".localized)
    }
    override func popViewController() {
        self.navigationController?.popViewControllers(viewsToPop: 2)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
    @IBAction func notNowTapped(_ sender: Any) {
        GlobalData.shared.registrationType = .noKyc
        presenter.navigateToEnterEmail()
    }
    
}


// MARK: - UITableViewDataSource
extension RegistrationMethodsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.dataSource[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: model.reusableIdentifier()) as? StandardCell else {
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
extension RegistrationMethodsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
