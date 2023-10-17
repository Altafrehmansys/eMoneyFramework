//
//  HomeViewController.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 12/04/2023.
//

import UIKit

class HomeViewController: BaseViewController, HomeScreenViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var registrationPendingFloatingView: UIView!
    @IBOutlet weak var registrationPendingLabel: UILabel!
    @IBOutlet weak var completeRegistrationLabel: UILabel!
    @IBOutlet weak var registerNowButton: BaseButton!
    
    
    // MARK: - Attributes
    var presenter: HomeScreenPresenterProtocol!
    
    
    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        self.init(nibName: "HomeViewController", bundle: bundle)
        //HomeViewController.self))
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
//        let vc = BillPaymentSuccessRouter.setupModule(viewData: nil, input: nil)
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true)

     //   self.present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? BaseNavigationController)?.setupNavigationWithBackground(image: "navigation-background")
        
        presenter.getAvailableBalance()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.navigationController as? BaseNavigationController)?.navigationBarWithWhiteBackground()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(RegistrationMethodsViewController.self) release from memory")
    }
    
    func setupUI() {
        self.registerNotifications()
        
        self.setupNavigation()
        self.setupTableView()
        self.setupFloatingView()
    }
    
    private func setupFloatingView() {
        registrationPendingFloatingView.isHidden = true
        registrationPendingFloatingView.cornerRadius = 16
        registrationPendingFloatingView.addShadow(shadowOpacity: 1, shadowRadius: 12, shadowOffset: CGSize(width: 0, height: 4), shadowColor: AppColor.eAnd_Shadow)
        
        registrationPendingLabel.text = "Registration pending"
        registrationPendingLabel.font = AppFont.appMedium(size: .body4)
        registrationPendingLabel.textColor = AppColor.eAnd_Black_80
        
        completeRegistrationLabel.text = "Complete your registration for a seamless experience."
        completeRegistrationLabel.font = AppFont.appRegular(size: .body5)
        completeRegistrationLabel.textColor = AppColor.eAnd_Grey_100
        
        registerNowButton.setTitle("Register now", for: .normal)
        registerNowButton.type = .PlainButton
        registerNowButton.titleLabel?.font = AppFont.appMedium(size: .body4)
    }
    
    private func setupNavigation() {
        addBarButtonItemWithImage(UIImage(named: "e&money-logo"), .left, self, #selector(emptyTapped))
        addBarButtonItemWithImage(UIImage(named: "notification-bell"), .right, self, #selector(emptyTapped))
        addBarButtonItemWithImage(UIImage(named: "profile-circle"), .right, self, #selector(emptyTapped))
    }
    
    @objc func emptyTapped() {
        //self.presenter.navigateToSendMoney()
        let vc = IMTSendMoneyRouter.setupModule()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(upgradeFlowCompletion(_:)), name: .onUpgradeFlowCompletion, object: nil)
    }
    
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc func upgradeFlowCompletion(_ notification: Notification) {
        self.presenter.viewDidLoad()
    }
}


// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
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
extension HomeViewController: UITableViewDelegate {
    
}

