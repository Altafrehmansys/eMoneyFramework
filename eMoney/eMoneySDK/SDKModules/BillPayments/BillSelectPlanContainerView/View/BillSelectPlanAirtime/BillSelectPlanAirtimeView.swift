//
//  BillSelectPlanAirtimeView.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 29/05/2023.
//

import UIKit

protocol BillSelectPlanProductDelegate: AnyObject {
    func didSelect(product: Product)
}
class BillSelectPlanAirtimeView: UIView, NibInstantiatable {
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var amountTextField: BaseAmountField!
    @IBOutlet weak var amountSlider: UISlider!
    @IBOutlet weak var sliderMinLabel: UILabel!
    @IBOutlet weak var sliderMaxLabel: UILabel!

    // MARK: - Properties
    private struct Constants {
        let collectionViewCellSpace: CGFloat = 6
        let collectionViewCellHeight: CGFloat = 64
        let collectionViewVerticalSpace: CGFloat = 12
    }
    var datasource = [Product]() {
        didSet {
            setHeightForCollection()
            collectionView.reloadData()
        }
    }
    weak var delegate: BillSelectPlanProductDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    private func setupUI() {
        loadNib()
        setupCollectionView()
        setHeightForCollection()
        setSlider()
        setAmountTextField()
    }
    
    private func setAmountTextField() {
        amountTextField.fieldTypeEnum = .disable
        amountTextField.currentColor = AppColor.eAnd_Black_80
        amountTextField.settingView(desc: "")
    }
    private func setSlider() {
        amountSlider.setThumbImage(UIImage(named: "Knob"), for: .normal)
        amountSlider.minimumTrackTintColor =  AppColor.eAnd_Maroon
        amountSlider.maximumTrackTintColor =  AppColor.eAnd_Best_seller
        
    }
    
    private func setHeightForCollection() {
        collectionViewHeight.constant = (CGFloat(datasource.count) / 2) * (Constants().collectionViewVerticalSpace + Constants().collectionViewCellHeight)
    }

    
    private func loadNib() {
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        let view = BillSelectPlanAirtimeView.fromNib(inBundle: bundle, filesOwner: self)
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics: nil,
                                                      views: ["view": view]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics: nil,
                                                      views: ["view" : view]))
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "\(BillSelectPlanAiretimeSelectAmonutCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(BillSelectPlanAiretimeSelectAmonutCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setAmountTextField(amount: String) {
        amountTextField.text = amount
        amountSlider.value = Float(amount) ?? 0.0
    }
    
    func set(minAmount: String, maxAmout: String) {
        sliderMinLabel.text = minAmount
        sliderMaxLabel.text = maxAmout
    }
}

extension BillSelectPlanAirtimeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = datasource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BillSelectPlanAiretimeSelectAmonutCollectionViewCell", for: indexPath) as? BillSelectPlanAiretimeSelectAmonutCollectionViewCell  else {
            return UICollectionViewCell()
        }
        cell.config(item: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
}

extension BillSelectPlanAirtimeView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - Constants().collectionViewCellSpace, height: Constants().collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants().collectionViewCellSpace
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(product: datasource[indexPath.row])
    }
}
