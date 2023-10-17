//
//  BankAccountInfoTableViewCell.swift
//  e&money
//
//  Created by Muhammad Uzair Akram on 24/04/2023.
//

import UIKit

class BankAccountInfoTableViewCell: StandardCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var verificationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var verificationAndTimeView: UIView!
    
    // MARK: - Class Properties
    private var timer: Timer? = nil
    
    enum PaymentSourceStatus: String {
        case active = "ACTIVE"
        case inProgress = "AWAITING_BENEFICIARY_COOL_OFF"
        case none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bankNameLabel.font = AppFont.appSemiBold(size: .body3)
        bankNameLabel.textColor = AppColor.eAnd_Black_80
        
        verificationLabel.font = AppFont.appRegular(size: .body5)
        verificationLabel.textColor = AppColor.eAnd_Error_100
        
        timeLabel.font = AppFont.appRegular(size: .body5)
        timeLabel.textColor = AppColor.eAnd_Black_80
    }
    
    override func configureCell() {
        if let model = cellModel as? BankAccountInfoTableViewCellModel {
            bankNameLabel.text = model.bank.bankName ?? ""
            
            let status = PaymentSourceStatus(rawValue: model.bank.paymentSourceStatus ?? "") ?? .none
            let coolOffPeriod = self.getCoolDownPeriod(date: model.bank.paymentSourceCoolOffPeriod ?? "")
            let showTimer = status == .inProgress && coolOffPeriod > 0
            if showTimer {
                self.setupBankData()
            }
            timeView.isHidden = !showTimer
            verificationAndTimeView.isHidden = status == .active
            verificationLabel.text = status == .active ? Strings.AddMoney.active : Strings.AddMoney.verificationInProgress
        }
    }
}

// MARK: - Class Methods
extension BankAccountInfoTableViewCell {
    
    private func setupBankData() {
        if let model = cellModel as? BankAccountInfoTableViewCellModel {
            let interval = getCoolDownPeriod(date: model.bank.paymentSourceCoolOffPeriod ?? "")
            
            if interval > 0 {
                self.startTimer(interval: interval)
            }
        }
    }
    
    private func getCoolDownPeriod(date: String) -> Int {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateformatter.timeZone = TimeZone(identifier: "UTC")
        guard let date = dateformatter.date(from: date) else {return 0}
        let now = Date()
        
        let components = Calendar.current.dateComponents([.second], from: now, to: date)
        return components.second ?? 0
    }
    
    private func startTimer(interval: Int) {
        var interval = interval
        self.stopTimer()
        
        self.timer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timerr in
            guard let self = self else {
                timerr.invalidate()
                return
            }
            if interval <= 0 {
                timerr.invalidate()
                self.stopTimer()
                if let model = self.cellModel as? BankAccountInfoTableViewCellModel {
                    model.actions?.cellSelected(1, model)
                }
                return
            }
            debugPrint("timer runing")
            self.timeLabel.text = self.secondsToTime(interval: interval)
            
            if let model = self.cellModel as? BankAccountInfoTableViewCellModel {
                model.remainingTimer = interval
                model.actions?.cellSelected(0, model)
            }
            
            interval = interval-1
        })
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func secondsToTime(interval:Int) -> String {
        let (h,m,s) = (interval / 3600, (interval % 3600) / 60, (interval % 3600) % 60)
        let h_string = h < 10 ? "0\(h)" : "\(h)"
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"
        return "\(h_string) h: \(m_string) m: \(s_string) s"
    }
}

// MARK: - Cell model
final class BankAccountInfoTableViewCellModel: StandardCellModel {
    var bank: BankAccountsListResponseModel.PaymentSources
    var remainingTimer: Int = 0
    
    init(actions: StandardCellModel.ActionsType = nil,
         bank: BankAccountsListResponseModel.PaymentSources) {
        self.bank = bank
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return BankAccountInfoTableViewCell.identifier()
    }
}
