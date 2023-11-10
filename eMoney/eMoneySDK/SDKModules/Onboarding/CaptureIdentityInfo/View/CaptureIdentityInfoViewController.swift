//
//  CaptureIdentityInfoViewController.swift
//  e&money
//
//  Created by Shujaat Ali Khan on 15/04/2023.
//  
//

import Foundation
import UIKit

enum UserUpdateType {
    case updateEidAndSelfi
    case updateEid
}

class CaptureIdentityInfoViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var stepsBar: BaseStepper!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var openCameraBtn: BaseButton!

    var delegate: SendDataSDK?
    // MARK: Properties

    var presenter: CaptureIdentityInfoPresenterProtocol?

    var isScreenTypeSelfi:Bool = false
    
    var updateType:UserUpdateType?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.isScreenTypeSelfi = isScreenTypeSelfi
        presenter?.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.changeScreenSize(size: .fullScreen, viewHeight: 0)
        setScreenSize(size: .fullScreen)
        NotificationCenter.default.post(name: .onChangeTopCloseButton, object: nil, userInfo: ["isShow":true])
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(RegistrationMethodsViewController.self)  release from memory")
    }
    
    func setupUI() {
        self.openCameraBtn.setTitle("open_camera".localized, for: .normal)
        
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        if !isScreenTypeSelfi {
            if let type = self.updateType {
                if type == .updateEid {
                    self.navigationItem.setTitle(title: "update_emirates_id".localized, subtitle: "capture_identity".localized)
                    //self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 2)
                    self.stepsBar.isHidden = true
                } else {
                    self.navigationItem.setTitle(title: "register".localized, subtitle: "capture_identity".localized)
                    self.stepsBar.addRedLine(noOfSteps: 2, currentStep: 1)
                }
            } else {
                self.navigationItem.setTitle(title: "register".localized, subtitle: "capture_identity".localized)
                self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 1)
            }
        } else {
            self.navigationItem.setTitle(title: "register".localized, subtitle: "verify_identity".localized)
            self.stepsBar.addRedLine(noOfSteps: 4, currentStep: 2)
        }
        
        createNavBackBtn()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - Acions
    
    @IBAction func openCameraTapped(_ sender: Any) {
        if !isScreenTypeSelfi {
            CommonMethods.checkCameraAccess { success in
                DispatchQueue.main.async {
                    if success {
                        let _ = EWalletEFROCRManager.init(delegate: self)
                    }
                }
            }
        }else{
            presenter?.moveToLivenessCheck()
        }
    }
}

extension CaptureIdentityInfoViewController: CaptureIdentityInfoViewProtocol {
    func reloadData() {
        let identifiers = presenter?.dataSource.map { $0.reusableIdentifier() }
        identifiers?.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
    
}
//44 32
// MARK: - UITableViewDataSource
extension CaptureIdentityInfoViewController: UITableViewDataSource {
    
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
extension CaptureIdentityInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let model = presenter.dataSource[indexPath.row]
//        model.actions?.cellSelected(indexPath.row, model)
    }
}

extension CaptureIdentityInfoViewController: EFROCRManagerDelegate{
    func documentReaderSDKAuthenticated() {
        print("documentReaderSDK Authenticated")
        
    }
    
    func documentReaderSDKInitialized() {
        print("documentReaderSDK Initialized")
        presenter?.moveToEidScanScreen()
    }
    
    func documentReaderSDKAuthenticationFailed(_ errorString: String) {
        print("documentReaderSDK Authentication Failed")
    }
    
    func documentReaderSDKInitializationFailed(_ errorString: String) {
        print("documentReaderSDK Initialization Failed ")
        Alert.showBottomSheetError(title: errorString, message: "")
    }
    
    
}
