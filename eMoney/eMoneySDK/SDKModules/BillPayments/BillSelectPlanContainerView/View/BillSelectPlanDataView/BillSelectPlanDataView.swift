//
//  BillSelectPlanDataView.swift
//  e&money
//
//  Created by Muhammmed Mahmoud on 30/05/2023.
//

import UIKit

class BillSelectPlanDataView: UIView, NibInstantiatable {
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var gridentBottomOverlayView: UIView!

    // MARK: - Properties
    private struct Constants {
        let collectionViewCellSpace: CGFloat = 6
        let collectionViewCellHeight: CGFloat = 122
        let collectionViewVerticalSpace: CGFloat = 12
    }
    var datasource = [Product]() {
        didSet {
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
        setBottomOverlayView()
    }
    


    
    private func loadNib() {
//        let bundle = Bundle(for: type(of: self))
        let bundle = Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")
        let view = BillSelectPlanDataView.fromNib(inBundle: bundle, filesOwner: self)
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
        collectionView.register(UINib(nibName: "\(BillSelectPlanDataCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(BillSelectPlanDataCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setBottomOverlayView() {
        gridentBottomOverlayView.addGradient(colors: [UIColor(red: (255.0/255.0), green: (255.0/255.0), blue: (255.0/255.0), alpha: 0), UIColor(red: (255.0/255.0), green: (255.0/255.0), blue: (255.0/255.0), alpha: 0.73)],  locations: [0, 1], startPoint: CGPoint(x: 0, y: 0.1), endPoint:  CGPoint(x: 0, y: 1), cornerRadius: 0)
    }
    
    private func setNextbuttonContainer() {
        
    }
}


extension BillSelectPlanDataView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = datasource[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BillSelectPlanDataCollectionViewCell", for: indexPath) as? BillSelectPlanDataCollectionViewCell  else {
            return UICollectionViewCell()
        }
        cell.config(item: model)
        if cell.isSelected {
            cell.borderWidth = 2
            cell.borderColor = AppColor.eAnd_Red_100
        } else {
            cell.borderWidth = 0
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
}

extension BillSelectPlanDataView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - Constants().collectionViewCellSpace, height: Constants().collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants().collectionViewCellSpace
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.borderWidth = 2
        cell?.borderColor = UIColor.red
        delegate?.didSelect(product: datasource[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.borderWidth = 0
    }
}
