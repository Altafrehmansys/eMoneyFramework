//
//  AddBeneficiaryViewController.swift
//  e&money
//
//  Created by Qamar Iqbal on 15/06/2023.
//  
//

import Foundation
import UIKit

class AddBeneficiaryViewController: BaseViewController {

    // MARK: Properties
    var presenter: AddBeneficiaryPresenterProtocol!
    
    @IBOutlet weak var shareDetailsButton: BaseButton!
    @IBOutlet weak var returnButton: BaseButton!
    @IBOutlet weak var bgview: UIView!
    
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var bankLogo: UIImageView!
    @IBOutlet weak var bankName: UILabel!
    
    @IBOutlet weak var ibanTitle: UILabel!
    @IBOutlet weak var ibanSubtitle: UILabel!
    @IBOutlet weak var copyTxtBtn: UIButton!
    
    @IBOutlet weak var swiftTitle: UILabel!
    @IBOutlet weak var swiftSubTitle: UILabel!

    @IBOutlet weak var benificieryTitle: UILabel!
    @IBOutlet weak var benificierySubTitle: UILabel!
    
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var addressSubTitle: UILabel!
    
    @IBOutlet weak var accountNumberTitle: UILabel!
    @IBOutlet weak var accountNumberSubTitle: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var bottomTitle: UILabel!
    
    

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

extension AddBeneficiaryViewController: AddBeneficiaryViewProtocol {    
    func setupUI() {
        setupNavigation()
        
        shareDetailsButton.setTitle(Strings.AddMoney.shareDetails, for: .normal)
        shareDetailsButton.type = .GradientButton
        shareDetailsButton.addTarget(self, action: #selector(shareDetailsButtonTapped(_:)), for: .touchUpInside)

        returnButton.setTitle(Strings.AddMoney.returnTxt, for: .normal)
        returnButton.type = .PlainButton
        returnButton.addTarget(self, action: #selector(returnButtonTapped(_:)), for: .touchUpInside)
        
        copyTxtBtn.addTarget(self, action: #selector(copyTxtButtonTapped(_:)), for: .touchUpInside)

        
        bgview.layer.cornerRadius = 20.0
        bgview.layer.masksToBounds = true
        bgview.layer.borderWidth = 1.0
        bgview.layer.borderColor = AppColor.eAnd_Grey_10.cgColor
        bgview.backgroundColor = AppColor.eAnd_White
        
        topTitle.text = Strings.AddMoney.addUsAsABeneficiaryDES
        topTitle.textColor = AppColor.eAnd_Black_80
        topTitle.font = AppFont.appRegular(size: .body2)
        
        bankLogo.image = UIImage(named: "dubaiIslamic")
        bankName.text = "Dubai Islamic Bank"
        bankName.textColor = AppColor.eAnd_Black_80
        bankName.font = AppFont.appRegular(size: .body3)
        
        ibanTitle.text = Strings.AddMoney.iban
        ibanTitle.textColor = AppColor.eAnd_Grey_100
        ibanTitle.font = AppFont.appRegular(size: .body4)
        
        ibanSubtitle.text = "AE16 0240 0975  8520 9191  202"
        ibanSubtitle.textColor = AppColor.eAnd_Black_80
        ibanSubtitle.font = AppFont.appRegular(size: .body3)
        
        swiftTitle.text = Strings.AddMoney.swift
        swiftTitle.textColor = AppColor.eAnd_Grey_100
        swiftTitle.font = AppFont.appRegular(size: .body4)
        
        swiftSubTitle.text = "DUIBAEAD"
        swiftSubTitle.textColor = AppColor.eAnd_Black_80
        swiftSubTitle.font = AppFont.appRegular(size: .body3)
        
        benificieryTitle.text = Strings.AddMoney.beneficiaryName
        benificieryTitle.textColor = AppColor.eAnd_Grey_100
        benificieryTitle.font = AppFont.appRegular(size: .body4)
        
        benificierySubTitle.text = "e& money"
        benificierySubTitle.textColor = AppColor.eAnd_Black_80
        benificierySubTitle.font = AppFont.appRegular(size: .body3)
        
        addressTitle.text = Strings.AddMoney.address
        addressTitle.textColor = AppColor.eAnd_Grey_100
        addressTitle.font = AppFont.appRegular(size: .body4)
        
        addressSubTitle.text = "Sheikh Zayed Road"
        addressSubTitle.textColor = AppColor.eAnd_Black_80
        addressSubTitle.font = AppFont.appRegular(size: .body3)
        
        accountNumberTitle.text = Strings.AddMoney.yourEAccount
        accountNumberTitle.textColor = AppColor.eAnd_Grey_100
        accountNumberTitle.font = AppFont.appRegular(size: .body4)
        
        accountNumberSubTitle.text = GlobalData.shared.msisdn
        accountNumberSubTitle.textColor = AppColor.eAnd_Black_80
        accountNumberSubTitle.font = AppFont.appRegular(size: .body3)
        
        bottomTitle.text = Strings.AddMoney.addUsAsABeneficiaryDES1
        bottomTitle.textColor = AppColor.eAnd_Grey_100
        bottomTitle.font = AppFont.appRegular(size: .body5)
        
    }
    
    private func setupNavigation() {
        self.navigationItem.setTitle(title: Strings.AddMoney.addMoneyTitle, subtitle: Strings.AddMoney.addUsAsABeneficiary)
        self.createNavBackBtn()
    }

}


// MARK: - UITableViewDelegate
extension AddBeneficiaryViewController: UITableViewDelegate {}

// MARK: - Actions
extension AddBeneficiaryViewController {
    @objc func shareDetailsButtonTapped(_ sender: BaseButton) {
        var texts: [String: String] = [:]
        if let bank = bankName.text {
            texts["Bank"] = bank
        }

        if let iban = ibanSubtitle.text {
            texts["IBAN Number"] = iban
        }

        if let swift = swiftSubTitle.text {
            texts["Swift Title"] = swift
        }

        if let address = addressSubTitle.text {
            texts["Address Title"] = address
        }

        texts["Mobile Number"] = GlobalData.shared.msisdn

        var items: [Any] = []

        for (key, value) in texts {
            let item = "\(key): \(value)"
            items.append(item)
        }

        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }

    
    @objc func returnButtonTapped(_ sender: BaseButton) {
        self.popViewController()
    }
    
    @objc func copyTxtButtonTapped(_ sender: BaseButton) {
        guard let textToCopy = ibanSubtitle.text else {
                return
        }
        UIPasteboard.general.string = textToCopy
        Alert.showBannerView(title: "Copied!")
    }
}

