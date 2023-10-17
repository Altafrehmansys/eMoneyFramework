//
//  PaymentMachinesViewController.swift
//  e&money
//
//  Created by Qamar Iqbal on 02/05/2023.
//  
//

import Foundation
import UIKit

class PaymentMachinesViewController: BaseViewController {

    // MARK: Properties

    var presenter: PaymentMachinesPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(PaymentMachinesViewController.self) release from memory")
    }
}

extension PaymentMachinesViewController: PaymentMachinesViewProtocol {
    func setupUI() {
        setupTableView()
        setupNavigation()
        showFloatingController()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0)
    }
    
    private func setupNavigation() {
        var subtitleText = Strings.AddMoney.paymentMachines
        if presenter.getLocationNearByType == GetLocationsView.agentsView.rawValue {
            subtitleText = Strings.AddMoney.agents
        }
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: subtitleText)
        self.createNavBackBtn()
    }
    
    func showFloatingController(){
        let fpc = FloatingPanelController()
        fpc.delegate = self
        
        let vc = AgentsAndMachineRouter.setupModule(getLocationNearByType: presenter.getLocationNearByType)
        fpc.set(contentViewController: vc)
        
        fpc.surfaceView.grabberHandle.barColor = .lightGray
        fpc.surfaceView.grabberHandleSize.width = 60
        fpc.surfaceView.grabberHandlePadding = 10
        fpc.backdropView.backgroundColor = .clear
        
        if presenter.getLocationNearByType == GetLocationsView.agentsView.rawValue{
            fpc.layout = AgentsFloatingPanelLayout()
        }
        else{
            fpc.layout = MachineFloatingPanelLayout()
        }

        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 25
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 2.0)
        shadow.radius = 5
        shadow.spread = 3
        shadow.opacity = 0.2
        appearance.shadows = [shadow]
        fpc.surfaceView.appearance = appearance

        fpc.addPanel(toParent: self)
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tableView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PaymentMachinesViewController: UITableViewDataSource, UITableViewDelegate {
    
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
extension PaymentMachinesViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidEndAttracting(_ fpc: FloatingPanelController) {
        
        if let viewController = fpc.contentViewController as? AgentsAndMachineViewController {
            viewController.updateDataSource(with: fpc.state)
        }
    }
}

class MachineFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
        
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 17.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.2, edge: .bottom, referenceGuide: .safeArea),
    ]
}

class AgentsFloatingPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
        
    let anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 17.0, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.85, edge: .bottom, referenceGuide: .safeArea),
    ]
}

