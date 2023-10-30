//
//  AddMoneyViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//  
//

import Foundation
import UIKit

class AddMoneyViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    // MARK: Properties
    var presenter: AddMoneyPresenterProtocol!
    private var isDismiss = false

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadData()
        NotificationCenter.default.post(name: .onChangeScreenSize, object: nil, userInfo: ["size":"half"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
        self.backgroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        
        self.backgroundView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0.5
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !isDismiss {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.checkingTableViewScrolling()
    }
}

extension AddMoneyViewController: AddMoneyViewProtocol {
    
    func setupUI() {
        self.addGesture()
        self.setupTableView()
        
        view.backgroundColor = .clear
        backgroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        
        mainContainerView.layer.cornerRadius = 0
        mainContainerView.layer.masksToBounds = true
//        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
        
//        self.addSwipeDown(on: self.mainContainerView)
    }
    
    private func checkingTableViewScrolling() {
        var totalHeight = 0.0
        if presenter.dataSource.count > 0 {
            for index in 0 ... presenter.dataSource.count - 1 {
                let height = tableView.rectForRow(at: IndexPath(row: index, section: 0)).height
                totalHeight += height
            }
        }
        let bottomMargin = 20.0
        let actualHeight = totalHeight + bottomMargin
        let maxHeight = self.view.frame.height - 80
        let shouldScroll = maxHeight <= actualHeight
        tableView.isScrollEnabled = shouldScroll
    }
}

// MARK: - Actions
extension AddMoneyViewController {
    @objc func dismissView() {
        self.isDismiss = true
        presenter.dismissView()
    }
    
    @IBAction func crossButtonTappedAction(_ sender: UIButton) {
        self.isDismiss = true
        presenter.dismissView()
    }
}

// MARK: - UITableViewDataSource
extension AddMoneyViewController: UITableViewDataSource {
    
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
extension AddMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}


// MARK: - ReloadData
extension AddMoneyViewController {
    func reloadViewController(with message: String = "") {
        if !message.isEmpty {
            Alert.showBannerView(title: message)
        }
        self.presenter.loadData()
    }
}
