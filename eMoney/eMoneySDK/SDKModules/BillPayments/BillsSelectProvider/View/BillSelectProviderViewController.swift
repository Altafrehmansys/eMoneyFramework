//
//  BillSelectProviderViewController.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 25/05/2023.
//  
//

import Foundation
import UIKit

class BillSelectProviderViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet private weak var selectCountryLabel: UILabel!
    @IBOutlet private weak var selectProviderLabel: UILabel!
    @IBOutlet private weak var nextButtonContainer: UIView!
    @IBOutlet private weak var nextButton: BaseButton!
    
    // MARK: Properties

    var presenter: BillSelectProviderPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadData()
    }
    
    private func setNavigationController() {
        self.navigationItem.setTitle(title:self.presenter?.navTitle ?? "", subtitle: "Select  provider")
        createNavBackBtn()
    }
    
    private func setNextButton() {
        nextButton.type = .GradientCircleButton
        //nextButtonContainer.addGradient(colors: [AppColor.eAnd_Red_Gradient_Start, AppColor.eAnd_Red_Gradient_End], locations: [0, 1], startPoint: CGPoint(x: 0, y: 0.5), endPoint:  CGPoint(x: 1.0, y: 0.5))
    
       // nextButtonContainer.clipsToBounds = true
        self.nextButton.disable()

    }
    
    private func setFonts() {
        selectCountryLabel.font = AppFont.appRegular(size: .body2)
        selectProviderLabel.font = AppFont.appRegular(size: .body2)
    }
    
    private func setSelectCountriesView() {
        selectCountryLabel.set(text: "\(Strings.BillPayment.select_billing_country) *", withColorPart: "*", color: AppColor.eAnd_Red)
    }
    
    private func setSelectProvidersView() {
        selectProviderLabel.set(text: "\(Strings.BillPayment.select_a_network_provider) *", withColorPart: "*", color: AppColor.eAnd_Red)
    }
    
    
    @IBAction func selectCountryButtonTapped(_ sender: Any) {
        presenter?.didTapSelectCountry()
    }
    @IBAction func selectProviderButtonTapped(_ sender: Any) {
        presenter?.didTapSelectProvider()
    }
    @IBAction func nextButtonTapped(_ sender: Any) {
        presenter?.didTapNextButton()
    }
}

extension BillSelectProviderViewController: BillSelectProviderViewProtocol {
    func setUI() {
        self.tabBarController?.tabBar.isHidden = true
        setFonts()
        setNextButton()
        setNavigationController()
        setSelectCountriesView()
        setSelectProvidersView()
    }
    
    func updateCountry(name: String) {
        self.selectCountryLabel.textColor = AppColor.eAnd_Black_80
        self.selectCountryLabel.text = name
    }
    func updateProvider(name: String) {
        self.selectProviderLabel.textColor = AppColor.eAnd_Black_80
        self.selectProviderLabel.text = name
    }
    func enableNextButton() {
        self.nextButton.enable()
    }
    func disableNextButton() {
        self.nextButton.disable()
    }
}
