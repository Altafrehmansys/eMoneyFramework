//
//  BillManagementViewController.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 29/05/2023.
//  
//

import Foundation
import UIKit
import DropDown

class BillManagementViewController: BaseViewController {
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnPayBill: BaseButton!
    // MARK: Properties

    var presenter: BillManagementPresenterProtocol!
    let dropDown = DropDown()
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
}

extension BillManagementViewController: BillManagementViewProtocol {
   
    func setupUI() {
        view.backgroundColor = .white
        setUpNavbar()
        setupTableView()
        btnPayBill.setTitle("Pay bill", for: .normal)
    }

    private func setUpNavbar(){
        self.navigationItem.setTitle(title: "DEVA - Office",subtitle: "+922iuu234ui23iu4",isBoldTitle: true)
        
        self.addBarButtonItemWithImage(UIImage(named: "more-icon"), .right, self, #selector(moreButtonPressed))
        self.createNavBackBtn()
        
    }
    
    @objc func moreButtonPressed() {
     
        customizeDropDown(dataSource: ["Edit account details","Download statement","Delete this biller","Help"])
    }
    
    func customizeDropDown(dataSource:[String]) {
        
        dropDown.anchorView = self.navigationItem.rightBarButtonItem
        dropDown.bottomOffset = CGPoint(x:0, y: (self.navigationItem.rightBarButtonItem?.accessibilityFrame.height)! + 40)
        dropDown.cellHeight = 50
        dropDown.direction = .bottom
        dropDown.textFont = AppFont.appMedium(size: .body4)
        dropDown.textColor = AppColor.eAnd_Black_80
        dropDown.cancelAction = { [unowned self] in
        
        }
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        
        /*** IMPORTANT PART FOR CUSTOM CELLS ***/
        dropDown.cellNib = UINib(nibName: "CustomDropDownCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK"))
        dropDown.backgroundColor = .white
        dropDown.setupCornerRadius(16)
        dropDown.customCellConfiguration = { index, item, cell in
            guard let customCell = cell as? CustomDropDownCell else { return }
            if index == self.dropDown.dataSource.count - 1{
                customCell.separatorView.isHidden = true
            }else{
                customCell.separatorView.isHidden = false
            }
        }
        
        dropDown.selectionAction = { (index,item) in
           
            if index == 0 {
                self.dropDown.hide()
                self.presenter.editAccountDetails()
            }else if (index == 1){
                self.presenter.downloadStatement()
            }else if (index == 2){
                self.presenter.deleteBiller()
            }
            
        }
        /*** END - IMPORTANT PART FOR CUSTOM CELLS ***/
        
        dropDown.show()
        
    }
    
    func reloadData() {
        let identifiers = presenter.dataSource.map { $0.reusableIdentifier() }
        identifiers.forEach({tblView.register(UINib(nibName: $0, bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellReuseIdentifier: $0)})
        tblView.reloadData()
    }
    
    private func setupTableView() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.separatorStyle = .none
    }
    
}

// MARK: - UITableViewDataSource
extension BillManagementViewController: UITableViewDataSource {
    
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
extension BillManagementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = presenter.dataSource[indexPath.row]
        model.actions?.cellSelected(indexPath.row, model)
    }
}
