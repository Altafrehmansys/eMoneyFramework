//
//  BillSelectPlanContainerViewViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//  
//

import Foundation
import UIKit
import Kingfisher

class BillSelectPlanContainerViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var providerImage: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var userPhoneLabel: UILabel!
    @IBOutlet private weak var selectPlanOrAmountLabel: UILabel!
    @IBOutlet private weak var segmentControl: FloatingSegmentedControl!
    @IBOutlet private weak var airtimeView: BillSelectPlanAirtimeView!
    @IBOutlet private weak var dataView: BillSelectPlanDataView!
    @IBOutlet private weak var bundlesView: BillSelectPlanDataView!

    @IBOutlet private weak var nextBtn: BaseButton!

    // MARK: Properties

    var presenter: BillSelectPlanContainerViewPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
        setUI()
    }
    
    private func setUI() {
        setNavigationController()
        setSegmentControl()
        setFonts()
        setAirtimeView()
        setDataView()
        setBundlesView()
        airtimeView.isHidden = false
        dataView.isHidden = true
        nextBtn.disable()
        setNextBtn()

    }
    
    private func setAirtimeView() {
        airtimeView.delegate = self
    }
    private func setDataView() {
        dataView.delegate = self
    }
    private func setBundlesView() {
        bundlesView.delegate = self
    }
    
    private func setNextBtn() {
        nextBtn.type = .GradientCircleButton
    }
    private func setNavigationController() {
        self.navigationItem.setTitle(title: Strings.BillPayment.international_payments, subtitle:Strings.BillPayment.select_plan)
        createNavBackBtn()
    }
    
    private func setSegmentControl() {
        segmentControl.setSegments(with: [Strings.BillPayment.air_time,
                                          Strings.BillPayment.data,
                                          Strings.BillPayment.bundle])
        segmentControl.addTarget(self, action: #selector(segmentControlTapped(_:)))
        segmentControl.isAnimateFocusMoving = true
        segmentControl.focusedIndex = 0
    }
     // MARK: - Actions
    // Action for custom segmentControl
    @objc func segmentControlTapped(_ sender: FloatingSegmentedControl) {
        switch sender.focusedIndex {
        case 0:
            airtimeView.isHidden = false
            dataView.isHidden = true
            bundlesView.isHidden = true
        case 1:
            airtimeView.isHidden = true
            dataView.isHidden = false
            bundlesView.isHidden = true
        case 2:
            airtimeView.isHidden = true
            dataView.isHidden = true
            bundlesView.isHidden = false
        default:
            break
        }
    }
    
    private func setFonts() {
        usernameLabel.font = AppFont.appRegular(size: .body3)
        userPhoneLabel.font = AppFont.appRegular(size: .body4)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        presenter?.didSelectNextButton()
    }
}

extension BillSelectPlanContainerViewController: BillSelectPlanContainerViewViewProtocol {
    func updateUserData(number: String, name: String, imageURL: String) {
        usernameLabel.text = name
        userPhoneLabel.text = number
        let url = URL(string: imageURL)
        self.providerImage.kf.setImage(with: url)
    }
    func updateAirTimeview(data: [Product]) {
        airtimeView.datasource = data
    }
    
    func updateDataView(data: [Product]) {
        dataView.datasource =  data
    }
    
    func updateBundlesView(data: [Product]) {
        bundlesView.datasource = data
    }
    func hideNameLabel() {
        usernameLabel.isHidden = true
    }
}

extension BillSelectPlanContainerViewController: BillSelectPlanProductDelegate {
    func didSelect(product: Product) {
        switch segmentControl.focusedIndex {
        case 0:
            self.airtimeView.setAmountTextField(amount: product.sendAmount ?? "")
            self.airtimeView.set(minAmount: "\(product.minAmount ?? 0.0)", maxAmout: "\(product.maxAmount ?? 0.0)")
            
        default:
            break
        }
        
        nextBtn.enable()
        presenter?.didSelect(product: product)
    }
}
