//
//  DEWAOfficeViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 02/06/2023.
//  
//

import UIKit

class DEWAOfficeViewController: BaseViewController {

    // MARK: Outlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties

    var presenter: DEWAOfficePresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
        
        presenter?.didTapAutoPayButton()
    }
    
    private func setUI() {
        setNavigationController()
        setTableView()
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: "DEWA - Office", subtitle: "1681623465132")
        createNavBackBtn()
//        let moreIconImage =  UIImage(named: "more")
//      //  moreIconImage?.withTintColor(AppColor.eAnd_Black_80)
//        let moreButton = UIBarButtonItem(image: moreIconImage, style: .plain, target: self, action: #selector(moreButtonTapped))
//        moreButton.tintColor = AppColor.eAnd_Black_80
//        self.navigationItem.rightBarButtonItem = moreButton
    }
    
    private func setTableView() {
        tableView.register(UINib(nibName: "\(DEWAOfficePaidTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "DEWAOfficePaidTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func moreButtonTapped() {
        print("more list tapped")
    }
}

extension DEWAOfficeViewController: DEWAOfficeViewProtocol {
    
}

extension DEWAOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEWAOfficePaidTableViewCell") as? DEWAOfficePaidTableViewCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
