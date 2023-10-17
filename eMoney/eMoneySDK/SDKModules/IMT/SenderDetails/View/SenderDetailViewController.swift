//
//  SenderDetailViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 23/05/2023.
//  
//

import Foundation
import UIKit

class SenderDetailViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelSenderDetail: UILabel!
    
    @IBOutlet weak var buttonSaveDetail: BaseButton!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    // MARK: Properties

    var presenter: SenderDetailPresenterProtocol?

    // MARK: Lifecycle

    // MARK: - Init
    convenience init() {
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")!
        self.init(nibName: "SenderDetailViewController", bundle: bundle)
        //Bundle(for: SenderDetailViewController.self))
    }
 
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
       
    }
    
    // MARK: - Deallocation
    deinit {
        debugPrint("\(SenderDetailViewController.self)  release from memory")
    }
    
    func setupUI() {
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        labelSenderDetail.text = "sender_title".localized
        labelSenderDetail.font = AppFont.appRegular(size: .body2)
        labelSenderDetail.textColor = AppColor.eAnd_Black_80
        labelDescription.text = "sender_desc".localized
        labelDescription.font = AppFont.appRegular(size: .body4)
        labelDescription.textColor = AppColor.eAnd_Grey_100
        buttonSaveDetail.setTitle("save_detail".localized, for: .normal)
       
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
    
    @IBAction func buttonCrossTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func buttonSaveDetailTapped(_ sender: Any) {
    }
}

extension SenderDetailViewController: SenderDetailViewProtocol {
    
}
// MARK: - UITableViewDataSource
extension SenderDetailViewController: UITableViewDataSource {
    
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
extension SenderDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter?.dataSource[indexPath.row]
        model?.actions?.cellSelected(indexPath.row, model!)
    }
}
