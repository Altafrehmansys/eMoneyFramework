//
//  ManageSavedCardViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/05/2023.
//  
//

import Foundation
import UIKit

class ManageSavedCardViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var updateCardDetailsButton: BaseButton!
    @IBOutlet weak var removeThisMethodButton: BaseButton!
    
    @IBOutlet weak var viewBottomContraint: NSLayoutConstraint!
    
    // MARK: Properties
    var presenter: ManageSavedCardPresenterProtocol!
    private var keyboardHelper: KeyboardHelper?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(ManageSavedCardViewController.self) release from memory")
    }
}

// MARK: - Class Methods
extension ManageSavedCardViewController: ManageSavedCardViewProtocol {
    func setupUI() {
        self.addGesture()
        self.setupTableView()
        self.manageKeyboardHeight()
        
        view.backgroundColor = .clear
        backgroundView.backgroundColor = AppColor.eAnd_bottom_sheet_background
        
        mainContainerView.layer.cornerRadius = 20.0
        mainContainerView.layer.masksToBounds = true
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        updateCardDetailsButton.setTitle(Strings.AddMoney.updateCardDetails, for: .normal)
        updateCardDetailsButton.type = .GradientButton
        
        removeThisMethodButton.setTitle(Strings.AddMoney.removeThisCard, for: .normal)
        removeThisMethodButton.type = .PlainButton
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    private func manageKeyboardHeight() {
        keyboardHelper = KeyboardHelper { [unowned self] (animation, keyboardFrame, duration) in
            switch animation {
            case .keyboardWillShow:
                viewBottomContraint.constant = keyboardFrame.height
            case .keyboardWillHide:
                viewBottomContraint.constant = 24
            }
        }
    }
}

// MARK: - Actions
extension ManageSavedCardViewController {
    @objc func dismissView() {
//        presenter.dismissView()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
//        presenter.dismissView()
    }
}

// MARK: - UITableViewDataSource
extension ManageSavedCardViewController: UITableViewDataSource {
    
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
extension ManageSavedCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}

