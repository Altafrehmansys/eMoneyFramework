//
//  SelectCardViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 26/04/2023.
//  
//

import Foundation
import UIKit
import FSPagerView

class SelectCardViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var buttonConfirmSelection: BaseButton!
    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var buttonBrown: UIButton!
    @IBOutlet weak var buttonWhite: UIButton!
    @IBOutlet weak var buttonRed: UIButton!
    
    
    // MARK: Properties
    
    var presenter: SelectCardPresenterProtocol?
    var imagesArray = [UIImage]()
    var selectedColorEnum = SelectCardColor.Red
  
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setViewInterface()
    }
    
    // MARK: Setting The View Interface
    func setViewInterface(){
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        self.pagerView.itemSize = CGSize(width: 260, height: 164)
        self.pagerView.decelerationDistance = FSPagerView.automaticDistance
        
        self.pagerView.isInfinite = true
        self.isHideNavigation(false)
        self.navigationItem.setTitle(title: "select_card".localized)
        imagesArray.append(UIImage(named:"MaronCard")!)
        imagesArray.append(UIImage(named:"emoneycard")!)
        imagesArray.append(UIImage(named:"SliverCard")!)
        setButtonImages(index: 0)
        setFontsAndText()
    }
    func selectCardapiCallServer(){
        var cardModel = SelectCardRequestModel()
        cardModel.identity = GlobalData.shared.msisdn
        cardModel.cardColor = selectedColorEnum.rawValue
        cardModel.cardType = "PHYSICAL"
        presenter?.setCardColor(model: cardModel, cardType: selectedColorEnum)
    }
    
    func setButtonImages(index : Int){
        switch index {
        case 0 :
            self.buttonRed.setImage(UIImage(named:"redSmall"), for: .normal)
            self.buttonBrown.setImage(UIImage(named:"brownLarge"), for: .normal)
            self.buttonWhite.setImage(UIImage(named:"whiteCircle"), for: .normal)
            selectedColorEnum = SelectCardColor.Brown
        case 1 :
            self.buttonRed.setImage(UIImage(named:"redCircle"), for: .normal)
            self.buttonBrown.setImage(UIImage(named:"brownSmall"), for: .normal)
            self.buttonWhite.setImage(UIImage(named:"whiteCircle"), for: .normal)
            selectedColorEnum = SelectCardColor.Red
        case 2 :
            self.buttonRed.setImage(UIImage(named:"redSmall"), for: .normal)
            self.buttonBrown.setImage(UIImage(named:"brownSmall"), for: .normal)
            self.buttonWhite.setImage(UIImage(named:"whiteLarge"), for: .normal)
            selectedColorEnum = SelectCardColor.Gray
         default :
            self.buttonRed.setImage(UIImage(named:"redCircle"), for: .normal)
            self.buttonBrown.setImage(UIImage(named:"brownSmall"), for: .normal)
            self.buttonWhite.setImage(UIImage(named:"whiteCircle"), for: .normal)
            selectedColorEnum = SelectCardColor.Red
        }
        
    }
    func setFontsAndText(){
        labelHeading.text = "here_is_your_card".localized
        labelHeading.textColor = AppColor.eAnd_Black_80
        labelHeading.font = AppFont.appSemiBold(size: .h6)
        
        labelDesc.text = "customize_money_card".localized
        labelDesc.textColor = AppColor.eAnd_Grey_100
        labelDesc.font = AppFont.appRegular(size: .body3)
        
        buttonConfirmSelection.setTitle("confirm_selection".localized, for: .normal)
        buttonConfirmSelection.setTitleColor(AppColor.eAnd_White, for: .normal)
        buttonConfirmSelection.titleLabel?.font = AppFont.appSemiBold(size: .body2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    func scrollItemAndSetView(index:Int){
        pagerView.scrollToItem(at: index, animated: true)
        setButtonImages(index: index)
    }
    
    // MARK: IBActions
    
    @IBAction func buttonConfirmTapped(_ sender: Any) {
        selectCardapiCallServer()
       
    }
    
    @IBAction func buttonBrownTapped(_ sender: Any) {
       scrollItemAndSetView(index: 0)
    }
    @IBAction func buttonRedTapped(_ sender: Any) {
        scrollItemAndSetView(index: 1)
    }
    @IBAction func buttonWhiteTapped(_ sender: Any) {
        scrollItemAndSetView(index: 2)
    }
}

// MARK: Viper View Protocol
extension SelectCardViewController: SelectCardViewProtocol {
    
}

// MARK: FsPagerView Datasource
extension SelectCardViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imagesArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = imagesArray[index]
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        
        cell.contentView.layer.shadowRadius = 0
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        setButtonImages(index: index)
    }

}

// MARK: FsPagerView Delegate
extension SelectCardViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return true
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
     //   setButtonImages(index: index)
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        setButtonImages(index: targetIndex)
    }
    
    
    

}

