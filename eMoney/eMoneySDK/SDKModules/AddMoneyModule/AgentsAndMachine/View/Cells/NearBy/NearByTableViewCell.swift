//
//  NearByTableViewCell.swift
//  e&money
//
//  Created by Qamar Iqbal on 04/05/2023.
//

import UIKit
import CoreLocation

class NearByTableViewCell: StandardCell {

    @IBOutlet weak var outletLbl: UILabel!
    @IBOutlet weak var machineAgentLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!

    @IBOutlet weak var openNowBtn: UIButton!
    @IBOutlet weak var pinBtn: UIButton!
    
    @IBOutlet weak var btnBGView: UIView!
    
    @IBOutlet weak var seperatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    func setupUI() {
        
        outletLbl.font = AppFont.appSemiBold(size: .body2)
        outletLbl.textColor = AppColor.eAnd_Black_80
        
        machineAgentLbl.font = AppFont.appRegular(size: .body3)
        machineAgentLbl.textColor = AppColor.eAnd_Grey_70
        
        distanceLbl.font = AppFont.appRegular(size: .body3)
        distanceLbl.textColor = AppColor.eAnd_Grey_70
        
        btnBGView.backgroundColor = AppColor.eAnd_Success_10
        btnBGView.layer.cornerRadius = 2
        btnBGView.layer.masksToBounds = true

        seperatorView.backgroundColor = AppColor.eAnd_Grey_20
    }
    
    override func configureCell() {
        if let model = cellModel as? NearByTableViewCellModel {
            
            outletLbl.text = model.dataModel.name ?? ""
            machineAgentLbl.text = model.dataModel.addressShort ?? ""
            
            var distanceLblText = ""
            if let distance = model.dataModel.distance {
                distanceLblText = String(format: "%0.1f KMs", distance)
            }
            distanceLbl.text = distanceLblText
            
            let isOpen = model.dataModel.isOpen ?? false
            let btnTitle = isOpen ? Strings.AddMoney.openNow : Strings.AddMoney.closed
            openNowBtn.setTitle(btnTitle, for: .normal)
            
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: AppFont.appSemiBold(size: .body5),
                .foregroundColor: AppColor.eAnd_Success_100
            ]
            let attributedTitle = NSAttributedString(string: btnTitle, attributes: titleAttributes)
            openNowBtn.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
}

// MARK: - IBActions
extension NearByTableViewCell {
    @IBAction func openNowOrLoctionBtnAction(_ sender: Any) {
        if let model = self.cellModel as? NearByTableViewCellModel {
            model.actions?.cellSelected(0, model)
        }
    }
}

// MARK: - Cell model
final class NearByTableViewCellModel: StandardCellModel {
    let dataModel: AgentsAndMachineResponseModel.LocationsDataModel
    
    init(actions: StandardCellModel.ActionsType = nil, dataModel: AgentsAndMachineResponseModel.LocationsDataModel) {
        self.dataModel = dataModel
        super.init(actions: actions)
    }

    override func reusableIdentifier() -> String {
        return NearByTableViewCell.identifier()
    }
}
