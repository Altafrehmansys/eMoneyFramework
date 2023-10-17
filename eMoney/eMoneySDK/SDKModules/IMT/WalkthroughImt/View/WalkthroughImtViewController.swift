//
//  WalkthroughImtViewController.swift
//  e&money
//
//  Created by Muhammad Hassan Shafi on 13/06/2023.
//  
//

import Foundation
import UIKit

class WalkthroughImtViewController: BaseViewController {

    // MARK: IBOUTLETS
    @IBOutlet weak var viewSteps: BaseStepper!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var startSending: BaseButton!
    @IBOutlet weak var buttonTutorial: BaseButton!
    @IBOutlet weak var viewBottom: UIView!
    // MARK: Properties
    var walkThroughArray = [WalkthroughNotifications]()
    var currentIndex = 0
    var presenter: WalkthroughImtPresenterProtocol?
    var timer: Timer?
    var lastOffset = CGFloat()
    var timeInterval = 5.0

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUserInterface()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isHideNavigation(true)
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.changeImageAfterTimer()
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    // MARK: Setting View
    func setViewUserInterface(){
        self.collectionView.backgroundColor = .black
        self.collectionView.contentInsetAdjustmentBehavior = .never
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "OnboardingImageCell", bundle: Bundle(identifier: "com.app.taskLocalTester.asdf.asdf.asdf.eMoneySDK")), forCellWithReuseIdentifier: "OnboardingImageCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.semanticContentAttribute = LocaleManager.isRTLLanguage() ? .forceRightToLeft:.forceLeftToRight
        
        self.viewBottom.layer.cornerRadius = 24
        setNeedsStatusBarAppearanceUpdate()
        self.isHideNavigation(true)
        self.collectionView.isScrollEnabled = false
        viewSteps.isHidden = false
        setViewData()
        apiCallForIntroData()
        
    }
    func setViewData(){
        if walkThroughArray.count > 0 {
            lblDesc.text = walkThroughArray[currentIndex].message
        }
        
        self.collectionView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func didInternetErrorTryAgainTapped() {
        print("TRAY AGAIN TAPPED")
    }
    
    // MARK: timer to change image
    func changeImageAfterTimer(){
        if currentIndex < walkThroughArray.count - 1 {
            currentIndex = currentIndex + 1
        }
        else {
            currentIndex = 0
        }
        
        scrollToIndex(index: currentIndex)
        print(currentIndex)
        let currentStep = currentIndex + 1
        if walkThroughArray.count > 0 {
            viewSteps.addRedLine(noOfSteps: walkThroughArray.count, currentStep: currentStep)
        }
    }
    func scrollToIndex(index:Int) {
        let rect = self.collectionView.layoutAttributesForItem(at:IndexPath(row: index, section: 0))?.frame
        if rect != nil {
            self.collectionView.scrollRectToVisible(rect!, animated: true)
            setViewData()
        }
    }
    func setDataOnScroll(){
        if currentIndex < walkThroughArray.count  {
        }
        else {
            currentIndex = 0
        }
        let currentStep = currentIndex + 1
        viewSteps.addRedLine(noOfSteps: walkThroughArray.count, currentStep: currentStep)
        setViewData()
    }
    // MARK: API Call
    func apiCallForIntroData()  {
        presenter?.loadWalkthroughIntroData()
    }
    // MARK: IB Actions
    
    @IBAction func buttonStartSendingTapped(_ sender: Any) {
        presenter?.navigateToStartSending()
    }
    
    @IBAction func buttonTutorialTapped(_ sender: Any) {
    }
    
}

extension WalkthroughImtViewController: WalkthroughImtViewProtocol {
    func walkThroughIntroRequestError(error: AppError) {
        print(error.errorDescription)
    }
    
    func walkThroughIntroRequestResponse(response: WalkthroughIntroResponseModel) {
        walkThroughArray.append(contentsOf: response.data?.notifications ?? [])
        self.viewSteps.addRedLine(noOfSteps: walkThroughArray.count, currentStep: 1)
        self.collectionView.reloadData()
    }
}
// MARK: UICollectionViewDatasource
extension WalkthroughImtViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return walkThroughArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingImageCell", for: indexPath) as? OnboardingImageCell else {
            fatalError("Unable to dequeue OnboardingImageCell.")
        }
        cell.setCellData(onboardingObj: walkThroughArray[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension WalkthroughImtViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeImageAfterTimer()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }
}
