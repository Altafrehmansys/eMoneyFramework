//
//  HorizontalCheckBoxCell.swift
//  e&money
//
//  Created by Muhammad Yousaf Yaqoob on 15/06/2023.
//

import UIKit

class HorizontalCheckBoxCell: StandardCell {

    @IBOutlet weak var btnPostpaid: UIButton!
    @IBOutlet weak var btnPrepaid: UIButton!
    override func configureCell() {
        setUpUI()
        if let model = cellModel as? HorizontalCheckBoxCellModel {
            btnPrepaid.setTitle(model.prePaidTitle, for:.normal)
            btnPostpaid.setTitle(model.postPaidTitle, for: .normal)
            btnPrepaid.setImage(UIImage(named: model.isprePaidSelected == model.isprePaidSelected ? "radio_unselected":"radio_selected"), for:.normal)
            btnPostpaid.setImage(UIImage(named: model.ispostPaidSelected == model.ispostPaidSelected  ? "radio_unselected":"radio_selected"), for:.normal)
        }
    }
    
    func setUpUI(){
        
        btnPrepaid.titleLabel?.textColor = AppColor.eAnd_Black_80
        btnPostpaid.titleLabel?.textColor = AppColor.eAnd_Black_80
        btnPrepaid.titleLabel?.font = AppFont.appRegular(size: .body4)
        btnPostpaid.titleLabel?.font = AppFont.appRegular(size: .body4)
    }
    @IBAction func didSelectPlan(_ sender:UIButton) {
        if let model = self.cellModel {
            cellModel?.actions?.cellSelected(sender.tag,model)
        }
    }
}
// MARK: - Cell Model
final class HorizontalCheckBoxCellModel: StandardCellModel {

    let postPaidTitle: String
    let prePaidTitle:String
    let ispostPaidSelected:Bool
    let isprePaidSelected:Bool
    init(actions: StandardCellModel.ActionsType = nil,
         postPaidTitle:String,
         prePaidTitle:String,
         ispostPaidSelected:Bool,
         isprePaidSelected:Bool) {
        self.postPaidTitle = postPaidTitle
        self.prePaidTitle = prePaidTitle
        self.ispostPaidSelected = ispostPaidSelected
        self.isprePaidSelected = isprePaidSelected
        super.init(actions: actions)
    }
    
    override func reusableIdentifier() -> String {
        return HorizontalCheckBoxCell.identifier()
    }
}
